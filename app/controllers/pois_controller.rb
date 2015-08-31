require 'google'

class PoisController < ApplicationController

include Google

	def index
		@user = User.find_by(id: params[:user_id])
		@loc = Location.find_by(id: params[:location_id])
		@pois = @user.locations.find(location_id= @loc.id).pois


	 end


	def show


	end


	def new	
	end


	def create
		google_places = params[:google_place]
		redirect_to new_user_location_trip_path

	end



end
