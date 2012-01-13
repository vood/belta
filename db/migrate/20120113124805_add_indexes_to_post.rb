class AddIndexesToPost < ActiveRecord::Migration
  def change
    add_index :posts, :title
    add_index :posts, :source, :unique => true
  end
end
