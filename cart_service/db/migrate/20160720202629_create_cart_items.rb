class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :quantity
      t.float :price
      t.references :order, index: true

      t.timestamps null: false
    end
    add_foreign_key :cart_items, :orders
  end
end
