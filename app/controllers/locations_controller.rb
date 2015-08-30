require 'google'

class LocationsController < ApplicationController
    
    include Google

    def index
        @user = User.find params[:id]
        @location = params[:location]
    end

    def create
        @name = params[:q]
        @user = User.first
        @user_id = @user.id
        p "Name: #{@name}"
        p "User_id: #{@user_id}"
        @location = Location.create(getLocation(@name))
        redirect_to user_location_path
    end

    def show
        @location = Location.find params[:user_id]
        @user = User.find params[:id]
        @user_id = @user.id
        @name = @location.name
        response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + @name + "&key=" + @key)
        json = JSON.parse(response.body)
        p json.results[0].geometry.location
        # @user = User.find params[:user_id]
        # @trips = Trip.find params[:trip_id]
        # @pois = Trip.pois
        # @image = Image.find params[:map_image]
    end

    private
      def location_params
        params.require(:location).permit(:name,:google_place, :latlong, :user_id)
      end
end
