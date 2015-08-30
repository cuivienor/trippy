class TripsController < ApplicationController

    def index
        @user = User.find params[:id]
        @trips = Trip.all
        @location = Location.find params[:id]
        @trips = @user.trips
    end

    def show
        @location = Location.find params[:google_place]  
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

