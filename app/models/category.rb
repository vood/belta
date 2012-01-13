#encoding: utf-8
class Category < ActiveRecord::Base
  acts_as_taggable
  has_many :category_posts
  has_many :posts, :through => :category_posts


  class << self
    attr_accessor :regexp_cache
  end

  @regexp_cache = {}

  after_save :update_regexp_cache
  after_destroy :update_regexp_cache

  def self.matched *strs
    str = strs.join(" ")
    id = self.regexps.select { |i, regex| regex.match(str) }.keys.first
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
    Regexp.union(tag_list.map { |tag| /\b#{Regexp.escape(tag)}\b/u }) if tag_list.length
  end

  def to_s
    title
  end

  private

  def update_regexp_cache
    destroyed? ? self.class.regexp_cache[id] = tags_as_regexp : self.class.regexp_cache.delete(id)
  end
end
