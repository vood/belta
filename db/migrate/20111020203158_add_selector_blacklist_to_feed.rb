class AddSelectorBlacklistToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :selector_blacklist, :string
  end
end
