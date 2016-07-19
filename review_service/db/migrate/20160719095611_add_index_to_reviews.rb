class AddIndexToReviews < ActiveRecord::Migration
  def change
  	add_index "reviews", ["user_id", "item_id"], :unique => true
  end
end
