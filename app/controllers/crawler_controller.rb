# encoding: utf-8
require 'open-uri'
class CrawlerController < ApplicationController
  def index
    feeds = {
        'http://it.tut.by/rss.xml' => '#article_body',
        'http://www.ej.by/news/it/it.rss' => 'body',
        'http://feeds.feedburner.com/providers_by' => 'body',
        'http://news.21.by/pub/rss/all.rss' => 'body'
    }

    regex = Category.all(:include => :tags).collect { |c| [c.id, Regexp.union(c.tag_list)] }

    Feedzirra::Feed.fetch_and_parse(feeds.keys).values.each do |feed|
      feed.entries.each do |entry|
        regex.each do |r|
          create_or_update_post(entry, r[0], feeds[feed.url]) if  entry_matches(entry, r[1])
        end
      end
    end
  end

  def create_or_update_post entry, category_id, selector
    Post.find_or_create_by_source(entry.url,
                                  :title => entry.title,
                                  :body => get_body(entry, selector),
                                  :category_ids => [category_id]).save()
  end

  def get_body entry, selector
    Nokogiri::HTML(open(entry.url)).css(selector).first.text
  end

  def entry_matches entry, regex
    entry.title.match(regex) || entry.summary.match(regex)
  end
end
