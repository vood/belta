class RemoveXpathSelector < ActiveRecord::Migration
  def change
    remove_column :feeds, :xpath_selector
  end
end
