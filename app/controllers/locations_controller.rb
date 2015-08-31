require 'google'

class LocationsController < ApplicationController
    
    include Google

    def index
        @user = User.find params[:id]
        @location = params[:location]
    end

    def create
        name = params[:q]
        location = Location.new(getLocation(name))
        if location.valid?
          location.save
        else
          location = Location.find_by(google_place: location.google_place)
        end
        user = User.find(params[:user_id])
        redirect_to user_location_path(user, location)
    end

    def show
        @location = Location.find(params[:id])
        @user = User.find params[:user_id]
        @suggestions = getPois(@location.latlong)
    end

    private
      def location_params
        params.require(:location).permit(:name,:google_place, :latlong, :user_id)
      end
end
