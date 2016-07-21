class UserModificationAddPhoneNumber < ActiveRecord::Migration
  def self.up
  	add_column :users, :phone_number, :string
  end
end