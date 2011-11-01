# encoding: UTF-8
class Post < ActiveRecord::Base

  has_and_belongs_to_many :related,
                          :class_name => 'Post',
                          :join_table => 'related_posts',
                          :foreign_key => :post_id,
                          :association_foreign_key => :related_post_id

  TITLES = { 'Позитивная' => 1, 'Нейтральная' => 0, 'Негативная' => -1 }.invert

  belongs_to :theme
  has_many :category_posts
  has_many :categories, :through => :category_posts

  def rating_title
    TITLES[self.rating || 1]
  end

  def published_or_created_at
    self.published_at || self.created_at
  end

  def create_or_update_by_source params
    related_post = self.find_by_title(params[:title])
    post = self.find_or_initialize_by_source(params[:source]).update_attributes(params)
    related_post.related.insert(post) if related_post
  end
end
