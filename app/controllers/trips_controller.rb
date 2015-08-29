class TripsController < ApplicationController
	# Our landing/home page is able to show (if any) a user's saved and mapped out trip
	def index
	end
	# From the landing/home page user can view a specific route they've already saved
	def show
	end

	# The results page after compiling the data. Displays map and directions
	def new
		response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{start}&destination=#{ending}&mode=walking&waypoints=optimize=true|#{way points, pipes between each}&sensor=false&key=AIzaSyCw2wYoFzAnvsFrxkolKpuht5JkM3UeIZ0")
	end

	# Saves the info from results page
	def create
	end

end