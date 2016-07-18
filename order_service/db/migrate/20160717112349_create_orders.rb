class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_number
      t.date :date
      t.integer :status

      t.timestamps null: false
    end
  end
end
