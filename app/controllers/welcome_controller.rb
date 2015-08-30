require 'google'

class WelcomeController < ApplicationController

  include Google
  
  def index
  end

  def search
    response = getLocation(params[:location])
    binding.pry
  end

end


# #This needs to be set in the heroku profile
# 		# Set heroku env like this "$ heroku config:add 'key'='value'"
# 		#Google API key = AIzaSyCw2wYoFzAnvsFrxkolKpuht5JkM3UeIZ0
# 		api = ENV["GOOGLEAPI"]
# 		#for multiple waypoints, save all into an array, then split and join with "|"
# 		response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{start}&destination=#{ending}&mode=walking&waypoints=optimize=true|#{way points, pipes between each}&sensor=false&key=#{api}")

				
# 		# Legs
# 			puts "*****************    LEGS OF JOURNEY    ****************"
# 				# From location to to location
# 				puts google.routes[0].legs

# 		# Steps
# 			puts "*****************    STEPS    ****************"
# 				# overview
# 				puts google.routes[0].legs[0].steps

# 			# the following is for each individual step in the leg
# 			puts "*****************    START    ****************"
# 				# starting lat & long
# 				puts "lat: "+google.routes[0].legs[0].steps[0].start_location.lat
# 				puts "long: "+google.routes[0].legs[0].steps[0].start_location.lng

# 			puts "*****************    END    ****************"
# 				# ending lat & long
# 				puts "lat: "+google.routes[0].legs[0].steps[0].end_location.lat
# 				puts "long: "+google.routes[0].legs[0].steps[0].end_location.lng

# 			puts "*****************    DISTANCE    ****************"
# 				# total distance 
# 				puts "distance: "+google.routes[0].legs[0].steps[0].distance.text

# 			puts "*****************    DURATION    ****************"
# 				# total time duration
# 				puts "duration: "+google.routes[0].legs[0].steps[0].duration.text

# 			puts "*****************    DIRECTIONS    ****************"
# 				# directions (note: part of directions have 'bold' tags for html use)
# 				puts "direction: "+google.routes[0].legs[0].steps[0].html_instructions