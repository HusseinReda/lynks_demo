class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  STREAM_URL = "http://localhost:3000/stream/"
  AUTH_URL = "http://localhost:3001/"
  ORDERS_URL = "http://localhost:3002/orders/"
  STORE_URL = "http://localhost:3003/"
  CART_URL = "http://localhost:3004/carts/"
  REVIEW_URL = "http://localhost:3005/reviews/"
  private
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]

	end 
end
