class ReviewsController < ApplicationController
  def new
  	if current_user_email==nil
      redirect_to users_login_path, notice: "You need to log in first"
    end
  end

  def create
  		
  end

  def edit
  end

  def delete
  end
end
