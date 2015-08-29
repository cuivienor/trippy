class TripsController < ApplicationController

    def index
        @user = User.find params[:user_id]
        @trips = @user.trips
    end

    def show
        @user = User.find params[:user_id]
        @trips = Trip.find params[:trip_id]
        @pois = @user.pois.find params[:trip_id]
        @image = Image.find params[:map_image]
    end

    def create
        @trip = Trip.create(params[:trip_id])
        @user = User.find params[:user_id]
        @poi = POI.find params[:poi_id]
        @location = Location.find params[:google_place]
        @direction = Direction.find params[:trip_id]
        @image = @trip.map_image
        @trip.users << @user
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
