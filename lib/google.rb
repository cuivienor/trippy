require 'httparty'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  APIKEY = ENV['GOOGLEAPIKEY']
  
  def getLocation(name)
    query = URI.encode_www_form('query' => name, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    name = response["results"][0]["name"].to_s
    google_loc = response["results"][0]["geometry"]["location"]["lat"].to_s + "," + response["results"][0]["geometry"]["location"]["lng"].to_s
    place_id = response["results"][0]["place_id"].to_s
    location_params = {name: name, latlong: google_loc, google_place: place_id}
  end

  def getPois(place_id)
    #return array of POIS [{place_id, name}]
  end

  def getDirections(pois_array_of_place_ids)
    # return array of instructions (strings)
  end
  
end
