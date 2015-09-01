require 'google'

class WelcomeController < ApplicationController
skip_before_action :require_login, only: [:index, :search]

  include Google
  
  def index
  	@trip = Trip.all
  	if @trip
  		@rand = Trip.order("RANDOM()").first
  	end

  	if logged_in?
  		redirect_to user_path(session[:user_id])
    	end
  end

  def search
  	name = params[:q]
		@location = getLocation(name)
		if @location 
			@suggestions = getPois(@location[:latlong])
		end
  end

end
