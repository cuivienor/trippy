class PoisController < ApplicationController

	def index
		@pois = Poi.all
		@location = Location.all

		@pois = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7127837,-74.0059413&radius=500&types=points_of_interest&rankby=prominence&key=AIzaSyCw2wYoFzAnvsFrxkolKpuht5JkM3UeIZ0")

	end

	def new

	end


end
