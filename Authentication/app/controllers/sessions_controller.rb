class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])	
  		session[:user_id] = user.id
  		render :json => {:error_msg=>"log in successful",:user_id=>user.id}
  	else
  		render :json => {:error_msg=>"Invalid email or password"}
  	end
  end

  def destroy
  	session[:user_id] = nil
  end
end
