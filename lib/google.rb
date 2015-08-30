require 'httparty'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  APIKEY = ENV['GOOGLEAPIKEY']
  
  def getLocation(name)
    query = URI.encode_www_form('query' => name, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    # parse response to have only place_id, lat,long, name
  end

  def getPois(place_id)
    #return array of POIS [{place_id, name}]
  end

  def getDirections(starting,ending,array_of_place_ids)
    waypoints = array_of_place_ids.split(" ")
    waypoints = waypoints.join("|place_id:")
    params = URI.encode_www_form('origin' => starting, 'destination' => ending, 'mode' => 'walking', 'waypoints' => "optimize=true|place_id:#{waypoints}", 'sensor' => false, 'key' = APIKEY)
    link = TextDirectionBase + params
    binding.pry
    response = HTTParty.get(link)
  end
  
end
