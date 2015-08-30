
class TripsController < ApplicationController

    @key = AIzaSyCw2wYoFzAnvsFrxkolKpuht5JkM3UeIZ0

    def index
        @user = User.find params[:id]
        @location = Location.find params[:id]
        @trips = @user.trips
    end

    def show
        @location = Location.find params[:google_place]
        response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + @location + "&key=" + @key)
        json = JSON.parse(response.body)
        p json.results[0].geometry.location
        # @user = User.find params[:user_id]
        # @trips = Trip.find params[:trip_id]
        # @pois = Trip.pois
        # @image = Image.find params[:map_image]
    end

    def create
        @trip = Trip.create(trip_params)
        @poi = POI.find params[:poi_id]
        @location = Location.find params[:google_place]
        @direction = Direction.find params[:trip_id]
        @image = @trip.map_image
        @trip.pois << @poi
        @trip.locations << @location
        @trip.directions << @direction
        @trip.images << @image
        redirect_to '/trip/show'
    end

    private
      def trip_params
        params.require(:trip).permit(:map_image,:user_id, :location_id)
      end
end

