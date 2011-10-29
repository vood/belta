class AddRequiredToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :required, :boolean
  end
end
