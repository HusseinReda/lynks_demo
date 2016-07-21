class User < ActiveRecord::Base
	

	validates_uniqueness_of :email 
	validates :first_name, length: { maximum: 30 } ,presence: true
	validates :last_name, length: { maximum: 30 } ,presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true
	validates :password, confirmation: true
	has_secure_password
	validates :security_question, presence: true
	validates :answer, presence: true
	validates :address, presence: true
	validates :phone_number, presence: true
end
