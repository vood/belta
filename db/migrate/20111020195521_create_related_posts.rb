class CreateRelatedPosts < ActiveRecord::Migration
  def change
    create_table :related_posts, :id => false do |t|
      t.integer :post_id
      t.integer :related_post_id
    end
  end
end
