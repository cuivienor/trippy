require 'google'

class WelcomeController < ApplicationController
skip_before_action :require_login, only: [:index, :search]

  include Google
  
  def index
  	if logged_in?
  		redirect_to user_path(session[:user_id])
  	else
  		redirect_to user_path(0)
  	end
  end

  def search
    response = getLocation(params[:location])
  end

end
