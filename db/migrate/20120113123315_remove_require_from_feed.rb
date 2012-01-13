class RemoveRequireFromFeed < ActiveRecord::Migration
  def change
    remove_column :feeds, :required
  end
end
