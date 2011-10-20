class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :selector
      t.boolean :xpath_selector

      t.timestamps
    end
  end
end
