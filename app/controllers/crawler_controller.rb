# encoding: utf-8
require 'open-uri'
class CrawlerController < ApplicationController
  def index
    @feeds = Feed.all_by_url
    Feedzirra::Feed.fetch_and_parse(@feeds.keys).each do |feed|
      parse_feed_entry feed
    end
    redirect_back :notice => "Новости успешно обновлены"
  end

  def parse_feed_entry rssfeed
    feed = @feeds[rssfeed[0]]
    rssfeed[1].entries.each do |entry|
      body = open(entry.url).read
      category = feed.category || Category.matched(entry.title, body)
      Post.create_or_update_by_source(
          :source => entry.url,
          :title => entry.title,
          :body => Parser.parse(body, feed.selector, feed.selector_blacklist),
          :published_at => entry.published,
          :categories => [category]
      ) if category
    end
  end
end
