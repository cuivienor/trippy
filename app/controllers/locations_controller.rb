class LocationsController < ApplicationController
    
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
        response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + @name + "&key=" + ENV["GOOGLE_KEY"])
        @google_loc = response["results"][0]["geometry"]["location"]["lat"].to_s + "," + response["results"][0]["geometry"]["location"]["lng"].to_s
        @place_id = response["results"][0]["place_id"].to_s
        @location = Location.create({name: @name, google_place: @place_id, latlong: @google_loc, user_id: @user_id})
        binding.pry
        # redirect_to user_location_path
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
