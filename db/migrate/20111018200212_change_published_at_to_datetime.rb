class ChangePublishedAtToDatetime < ActiveRecord::Migration
  def change
    change_column :posts, :published_at, :datetime
  end
end
