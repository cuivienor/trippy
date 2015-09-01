require 'google'

class WelcomeController < ApplicationController
skip_before_action :require_login, only: [:index, :search]

  include Google
  
  def index
  	if logged_in?
  		redirect_to user_path(session[:user_id])
  	# else
  	# 	root_path
  	end
  end

  def search
  	name = params[:q]
		@location = getLocation(name)
		if location 
			@suggestions = getPois(@location)
		end
  end

end
