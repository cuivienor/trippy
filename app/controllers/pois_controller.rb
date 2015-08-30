require 'google'

class PoisController < ApplicationController

include Google

	def index
		#@pois = Poi.all
		@location = Location.all

		@map = getPois("40.7127837,-74.0059413")


	end

	def new

	end


end
