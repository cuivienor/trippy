class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # user auth helpers
  def logged_in?
    session[:user_id]
  end

  def current_user?
    session[:user_id] == params[:user_id].to_i
  end

  def authorized?
    logged_in? && current_user?
  end

  
  
end
