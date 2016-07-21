class UsersController < ApplicationController
  def new
  end

  def signup
    if current_user_email
      respond_to do |format|
        format.html { redirect_to STREAM_URL+'show', notice: "logged in successfully" } and return 
      end
    end
    request_body = { :user =>{
          :first_name => params[:user][:first_name],
          :last_name => params[:user][:last_name],
          :gender => params[:user][:gender],
          :security_question => params[:user][:security_question],
          :answer => params[:user][:answer],
          :email => params[:user][:email],
          :password => params[:user][:password] ,
          :address => params[:user][:address],
          :phone_number => params[:user][:phone_number],
          :user_name => params[:user][:user_name]
        }
      }.to_json 
    
    response = RestClient.post AUTH_URL+'signup', request_body ,:content_type => :json , :accept => :json
    $response_body=JSON.parse(response)
    if response.code == 201
      redirect_to users_login_path
    else
      redirect_to :back, notice: "Sign up invalid"
    end
    
  end

  def login
  end

  def login_submission
    response = RestClient.get AUTH_URL+'login' ,{:params=>{:email => params[:email] , :password => params[:password]}}
    response_body = JSON.parse(response)
    if (response_body['error_msg'] == 'log in successful')
      session[:user_id] = response_body[:user_id]
      session[:email] = params[:email]
      respond_to do |format|
        format.html { redirect_to STREAM_URL+'show', notice: "logged in successfully" }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: "Invalid email or password" }
      end
    end

  end

  def logout
    session[:user_id] = nil
    session[:email] = nil
    respond_to do |format|
      format.html { redirect_to :back, notice: "logged out successfully" }
    end
  end

  def edit
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender, :security_question, :answer, :email, :password, :address, :phone_number, :user_name)
    end
end
