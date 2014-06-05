class SessionsController < ApplicationController
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])
    
    if @user
      sign_in(@user)
      redirect_to :back
    else
      flash[:errors] = "Invalid Credentials"
      @user = User.new(username: params[:user][:username])
      redirect_to :back
    end
  end
  
  def destroy
    sign_out
    redirect_to :back
  end
end
