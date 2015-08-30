require 'httparty'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  APIKEY = ENV['GOOGLEAPIKEY']
  PoiSearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  
  def getLocation(name)
    query = URI.encode_www_form('query' => name, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    name = response["results"][0]["name"].to_s
    google_loc = response["results"][0]["geometry"]["location"]["lat"].to_s + "," + response["results"][0]["geometry"]["location"]["lng"].to_s
    place_id = response["results"][0]["place_id"].to_s
    location_params = {name: name, latlong: google_loc, google_place: place_id}
  end

  def getPois(latlong)
      poi = 'points_of_interest'
      rank = 'prominence'
      radius = 500

    query = URI.encode_www_form('location' => latlong, 'types' => poi, 'radius' => radius, 'rankby' => rank, 'key' => APIKEY)
    link = PoiSearch + query
    response = HTTParty.get(link)["results"]

    #return array of POIS [{place_id, name}]
  end

  def getDirection(starting,ending,array_of_place_ids)
    waypoints = array_of_place_ids.split(" ")
    waypoints = waypoints.join("|place_id:")
    params = URI.encode_www_form('origin' => "place_id:#{starting}", 'destination' => "place_id:#{ending}", 'mode' => 'walking', 'waypoints' => "optimize=true|place_id:#{waypoints}", 'sensor' => false, 'key' => APIKEY)
    link = TextDirectionBase + params
    response = HTTParty.get(link)
  end
  
end
