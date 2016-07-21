class User < ActiveRecord::Base
	has_secure_password

	validates_uniqueness_of :email 
	validates :password, confirmation: true
	validates :user_name, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :first_name, length: { maximum: 30 }
	validates :last_name, length: { maximum: 30 }
	validates :email, presence: true
	validates :security_question, presence: true
	validates :answer, presence: true
	validates :address, presence: true
	validates :phone_number, presence: true
end
