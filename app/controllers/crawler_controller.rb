# encoding: utf-8
require 'open-uri'
class CrawlerController < ApplicationController
  def index
    @feeds = Feed.all_by_url
    Feedzirra::Feed.fetch_and_parse(@feeds.keys, :on_success => :parse_feed_entry)
    redirect_to :back, :notice => "Новости успешно обновлены" if request.env['HTTP_REFERER']
  end

  def parse_feed_entry url, rssfeed
    feed = @feeds[url]
    rssfeed.entries.each do |entry|
      body = open(entry.url)
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
