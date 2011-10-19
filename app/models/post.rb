# encoding: UTF-8
class Post < ActiveRecord::Base

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
end
