# encoding: utf-8
class CrawlerController < ApplicationController
  def index
    feeds = Feed.all

    regex = Category.all_regexps

    feeds.each do |feed|
      Feedzirra::Feed.fetch_and_parse(feed.url, :on_success => lambda { |entry|
        regex.each do |r|
          Post.create_or_update_by_source(
              :source => entry.url,
              :title => entry.title,
              :category_ids => [r[0]],
              :body => get_body(entry, feed),
              :published_at => entry.published) if feed.required || entry_matches(entry, r[1])
        end
      })
    end

    redirect_to :back, :notice => "Новости успешно обновлены"
  end
end
