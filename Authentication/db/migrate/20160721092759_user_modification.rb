class UserModification < ActiveRecord::Migration
  def self.up
    remove_column :users, :user_name
    remove_column :users, :phone_number
  end

  def self.down
    add_column :users, :phone_number, :string
  end
end
