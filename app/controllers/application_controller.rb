class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  # user auth helpers
  def logged_in?
    session[:user_id]
  end

  def current_user?
    if params[:user_id]
      session[:user_id] == params[:user_id].to_i
    else
      session[:user_id] == params[:id].to_i
    end
  end

  def authorized?
    logged_in? && current_user?
  end

 
  private
 
  def require_login
    if !authorized?
      flash[:error] = "User not authorized"
      if !logged_in?
        redirect_to root_path
      else 
        redirect_to user_path(session[:user_id])
      end
    end
  end
end
