class Category < ActiveRecord::Base
  acts_as_taggable
  has_many :category_posts
  has_many :posts, :through => :category_posts

  def to_s
    title
  end
end
