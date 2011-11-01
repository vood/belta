class Category < ActiveRecord::Base
  acts_as_taggable
  has_many :category_posts
  has_many :posts, :through => :category_posts

  def to_s
    title
  end

  def all_regexps
    Category.all(:include => :tags).collect { |c|
      [c.id, Regexp.union(c.tag_list.map { |tag| Regexp.new("\\b#{Regexp.escape(tag)}\\b", true) })]
    }
  end
end
