class DropColoumnNumberOrder < ActiveRecord::Migration
  def change
	remove_column :orders, :order_number
  end
end
