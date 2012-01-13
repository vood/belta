# encoding: utf-8
require 'open-uri'
class CrawlerController < ApplicationController
  def index
    @feeds = Feed.all_by_url
    @updated = 0
    @created = 0
    Feedzirra::Feed.fetch_and_parse(@feeds.keys, :on_success => lambda { |url, feed| parse_feed_entry(url, feed) if feed })
    redirect_back :notice => "Новости успешно обновлены. %d добавлено, %d обновлено." % [@created, @updated]
  end

  def parse_feed_entry url, rssfeed
    feed = @feeds[url]
    rssfeed.entries.each do |entry|
      body = open(entry.url).read
      body = Parser.parse(body, feed.selector, feed.selector_blacklist)
      category = feed.category || Category.matched(entry.title, strip_tags(body))
      if category
        post = Post.create_or_update_by_source(
            :source => entry.url,
            :title => entry.title,
            :body => body,
            :published_at => entry.published,
            :categories => [category])
        post.was_new ? @created += 1 : @updated +=1

      end
    end
  end
end
