class AddRatingAndThemeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :rating, :integer
    add_column :posts, :theme_id, :integer
  end
end
