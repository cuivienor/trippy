require 'google'

# This needs to be set in the heroku profile
# 		Set heroku env like this "$ heroku config:add 'key'='value'"
# 		APIKEY = ENV['GOOGLEAPIKEY']

class TripsController < ApplicationController
	include Google

	def index 
	end

	def new
		@user = User.find(params[:user_id])
    @location = Location.find(params[:location_id])
    @start = params[:start]
    @places = params[:google_place]
		#Arguments for getDirections still not set, current view is in beta
		starting = getLocation(params[:start])
	  points = getDirection(starting[:google_place],params[:google_place])
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

	def create

	end
	

end

