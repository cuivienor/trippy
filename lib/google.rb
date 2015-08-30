require 'httparty'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  APIKEY = ENV['GOOGLEAPIKEY']
  PoiSearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  
  def getLocation(name)
    query = URI.encode_www_form('query' => name, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    # parse response to have only place_id, lat,long, name
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

  def getDirections(pois_array_of_place_ids)
    # return array of instructions (strings)
  end
  
end
