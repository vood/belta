class Feed < ActiveRecord::Base
  belongs_to :category

  def self.all_by_url
    hash = {}
    all(:include => :category).each do |feed|
      hash[feed.url] = feed
    end
    hash
  end
end
