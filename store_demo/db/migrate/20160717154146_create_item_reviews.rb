class CreateItemReviews < ActiveRecord::Migration
  def change
    create_table :item_reviews do |t|
      t.references :item, index: true
      t.integer :user_id
      t.text :body
      t.float :rating

      t.timestamps null: false
    end
    add_foreign_key :item_reviews, :items
  end
end
