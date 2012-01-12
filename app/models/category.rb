class Category < ActiveRecord::Base
  acts_as_taggable
  has_many :category_posts
  has_many :posts, :through => :category_posts


  class << self
    attr_accessor :regexp_cache
  end

  @regexp_cache = {}

  after_save :update_regexp_cache

  def self.matched *strs
    id = self.regexps.select { |id, regex| strs.select { |str| regex.match(str.to_s) } }.keys.first
    where(:id => id).first
  end

  def self.regexps
    if self.regexp_cache.length == 0
      Category.all(:include => :tags).each do |c|
        self.regexp_cache[c.id] = c.tags_as_regexp
      end
    end
    @regexp_cache
  end

  def tags_as_regexp
    Regexp.union(tag_list.select { |tag| /\b#{Regexp.escape(tag)}\b/u })
  end

  def to_s
    title
  end

  private

  def update_regexp_cache
    self.class.regexp_cache[id] = tags_as_regexp
  end
end
