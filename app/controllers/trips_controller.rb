require 'google'

# This needs to be set in the heroku profile
# 		Set heroku env like this "$ heroku config:add 'key'='value'"
# 		APIKEY = ENV['GOOGLEAPIKEY']

class TripsController < ApplicationController
  include Google

  def index
    @trips = User.find(session[:user_id]).trips.where(location_id: params[:location_id])
    render layout: "trips_index"
  end

  def new
    @user = User.find(params[:user_id])
    @location = Location.find(params[:location_id])
    @places = params[:place_ids]
    @start = params[:start]


    # Validation for start text field because the form is not creating/saving
    # Redirects back to POI selection page if not filled in
    if @start == "" || @places == nil
      redirect_to :back
    else
      #Arguments for getDirections still not set, current view is in beta
      starting = getLocation(params[:start])
      points = getDirection(starting[:google_place],params[:place_ids])
      legs = points["routes"][0]["legs"]
      poly = points["routes"][0]["overview_polyline"]["points"]
      #Grabs the latitude and longitude of all points provided by the directions API and concats them for use in the static map
      all_points = []
      #'pins' maps out the points from start to finish
      pins = 1

      legs.each do |leg|
	marker = "markers=color:green|label:#{pins}|#{leg["end_location"]["lat"]},#{leg["end_location"]["lng"]}"
	all_points.push(marker)
	pins+=1
      end

      #split and join to put marker points in correct format
      markers = all_points.split(" ")
      markers = markers.join("&")
      @link = "https://maps.googleapis.com/maps/api/staticmap?size=640x640&#{markers}&path=weight:3%7Ccolor:red%7Cenc:#{poly}"
      #Stores all step by step directions in an array to get passed to template
      @directions = []
      @stops = []

      legs.each do |leg|
	@stops.push(leg["end_address"])
	leg["steps"].each do |steps|
	  @directions.push(steps["html_instructions"])
	end
      end
      @stops.shift
      @stops.pop
    end
    @trip_params = {
      map_image: @link,
      stops: @stops,
      directions: @directions,
      place_ids: @places
    }
    @trip = Trip.new
  end

  def create
    # TODO trip_params sanitization does not seem to get stops and trips
    # Need to look into it
    trip_details = trip_params
    trip_details[:stops] = params[:trip][:stops]
    trip_details[:directions] = params[:trip][:directions]
    trip_details[:user_id] = params[:user_id]
    trip_details[:location_id] = params[:location_id]
    trip = Trip.create(trip_details)
    params[:trip][:place_ids].each do |place_id|
      trip.pois << Poi.find_by(google_place: place_id)
    end
    redirect_to user_path(params[:user_id])
  end


  def trip_params
    params
      .require(:trip)
      .permit(:map_image, :stops, :directions)
  end

end

