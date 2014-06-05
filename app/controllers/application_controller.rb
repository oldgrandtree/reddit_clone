class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :signed_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by(token: session[:token])
  end
  
  def signed_in?
    !!current_user
  end
  
  def sign_in(user)
    session[:token] = user.token
    @current_user = user
  end
  
  def sign_out
    current_user.try(:reset_token!)
    session[:token] = nil
  end  
  
  def ensure_signed_in 
    unless signed_in?
      flash[:errors] = ["You must be signed in!"]
      redirect_to root_url
    end
  end
end
