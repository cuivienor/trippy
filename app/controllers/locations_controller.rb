class LocationsController < ApplicationController
    
    def index
        @user = User.find params[:id]
        @location = params[:location]
        # response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + @location + "&key=AIzaSyCw2wYoFzAnvsFrxkolKpuht5JkM3UeIZ0")
        # json = JSON.parse(response.body)
        # p json.results[0].geometry.location
        # @trips = @user.trips
    end

    def show
        @location = Location.find params[:user_id]
        @user = User.find params[:id]
        @user_id = @user.id
        response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + @location + "&key=" + @key)
        json = JSON.parse(response.body)
        p json.results[0].geometry.location
        # @user = User.find params[:user_id]
        # @trips = Trip.find params[:trip_id]
        # @pois = Trip.pois
        # @image = Image.find params[:map_image]
    end

    
end
