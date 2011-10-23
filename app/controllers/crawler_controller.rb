# encoding: utf-8
require 'open-uri'
class CrawlerController < ApplicationController
  def index
    feeds = Feed.all

    regex = Category.all(:include => :tags).collect { |c|
      [c.id, Regexp.union(c.tag_list.map { |tag| Regexp.new("\\b#{Regexp.escape(tag)}\\b", true) })]
    }
    feeds.each do |feed|
      f = Feedzirra::Feed.fetch_and_parse(feed.url)
      if f
        f.entries.each do |entry|
          regex.each do |r|
            create_or_update_post(entry, r[0], feed) if entry_matches(entry, r[1])
          end
        end
      end
    end

    redirect_to :back, :notice => "Новости успешно обновлены"
  end

  def create_or_update_post entry, category_id, feed
    related_post = Post.find_by_title(entry.title)
    post = Post.find_or_initialize_by_source(entry.url).update_attributes(:title => entry.title,
                                                                   :body => get_body(entry, feed.selector, feed.selector_blacklist),
                                                                   :category_ids => [category_id],
                                                                   :published_at => entry.published)
    related_post.related.insert(post) if related_post
  end

  def get_body entry, selector, blacklist = nil
    doc = Nokogiri::HTML(open(entry.url))
    doc.encoding = 'utf-8'

    html = doc.css(selector).to_html

    Sanitize.clean(html,
                   :elements => %w[
        b blockquote br cite em i li ol p pre
        q s small strike strong sub sup time u
      ], :remove_contents => %w[script])
  end

  def entry_matches entry, regex
    entry.title.match(regex) || entry.summary.match(regex)
  end
end
