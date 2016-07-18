class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :gender
      t.string :security_question
      t.text :answer
      t.string :email
      t.string :password_digest
      t.text :address
      t.integer :phone_number
      t.string :user_name

      t.timestamps null: false
    end
  end
end
