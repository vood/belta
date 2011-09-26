# encoding: utf-8
require 'net/http'
class CrawlerController < ApplicationController
  def index
    feeds = [
        'http://it.tut.by/rss.xml',
        'http://www.ej.by/news/it/it.rss',
        'http://feeds.feedburner.com/providers_by',
        'http://news.21.by/pub/rss/all.rss'
    ]

    regex = Category.all(:include => :tags).collect { |c| [c.id, Regexp.union(c.tag_list)] }

    Feedzirra::Feed.fetch_and_parse(feeds).values.each do |feed|
      feed.entries.each do |entry|
        regex.each do |r|
          create_or_update_post(entry, r[0]) if  entry_matches(entry, r[1])
        end
      end
    end
  end

  def create_or_update_post entry, category_id
    Post.find_or_create_by_source(entry.url,
                                  :title => entry.title,
                                  :body => get_body(entry),
                                  :category_ids => category_id).save()
  end

  def get_body entry
    Net::HTTP::get_response(URI.parse(entry.url))
#    dom = Nokogiri::HTML(response)
#    dom.
  end

  def entry_matches entry, regex
    entry.title.match(regex) || entry.summary.match(regex)
  end
end
