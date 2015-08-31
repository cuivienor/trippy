require 'httparty'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  TextDetailsBase = "https://maps.googleapis.com/maps/api/place/details/json?"
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

    suggestions = []
    response.each do |e|
      sugg = {}
      sugg["name"] = e["name"]
      sugg["google_place"] = e["place_id"]
      sugg["latlong"] = e["geometry"]["location"]["lat"].to_s+","+e["geometry"]["location"]["lng"].to_s

      suggestions << sugg 
    end    

    suggestions

    #return array of POIS [{place_id, name}]
  end

  def getDirection(starting,ending,array_of_place_ids)
    waypoints = array_of_place_ids.split(" ")
    waypoints = waypoints.join("|place_id:")
    params = URI.encode_www_form('origin' => "place_id:#{starting}", 'destination' => "place_id:#{ending}", 'mode' => 'walking', 'waypoints' => "optimize=true|place_id:#{waypoints}", 'sensor' => false, 'key' => APIKEY)
    link = TextDirectionBase + params
    response = HTTParty.get(link)
  end


  def getDetails(place_id)
    query = URI.encode_www_form('placeid' => place_id, 'key' => APIKEY)
    link = TextDetailsBase + query
    response = HTTParty.get(link)
    name = response["result"]["name"]
    binding.pry
    google_loc = response["result"]["geometry"]["location"]["lat"].to_s + "," + response["result"]["geometry"]["location"]["lng"].to_s
    details_params = {name: name, latlong: google_loc, google_place: place_id}
  end
  
end
