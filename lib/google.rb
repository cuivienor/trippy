require 'httparty'

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  TextDetailsBase = "https://maps.googleapis.com/maps/api/place/details/json?"
  PhotoBase = "https://maps.googleapis.com/maps/api/place/photo?"
  APIKEY = ENV['GOOGLEAPIKEY']
  PoiSearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  StaticSearch = "https://maps.googleapis.com/maps/api/staticmap?"


# get static map for Locaiton POI (location#show) page and Bookmark page (POI#index)
  def getStatic(latlongs)
    query = URI.encode_www_form('size' => '500x300', 'scale' => '2', 'markers' => 'color:blue|'+latlongs, 'key' => APIKEY)
    link = StaticSearch + query
    # response = HTTParty.get(link)

  end


#get location with text search for user#show and welcome#index
  def getLocation(name)
    query = URI.encode_www_form('query' => name, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    name = response["results"][0]["name"].to_s
    google_loc = response["results"][0]["geometry"]["location"]["lat"].to_s + "," + response["results"][0]["geometry"]["location"]["lng"].to_s
    place_id = response["results"][0]["place_id"].to_s
    location_params = {name: name, latlong: google_loc, google_place: place_id}
  end

#get points of interest for location#show and welcome#search
  def getPois(latlong)
      poi = 'points_of_interest'
      rank = 'prominence'
      radius = 5000

      query = URI.encode_www_form('location' => latlong, 'types' => poi, 'radius' => radius, 'rankby' => rank, 'key' => APIKEY)
    link = PoiSearch + query
    response = HTTParty.get(link)["results"]
    suggestions = []
    response.each do |e|
      unless e['types'].include?('locality')
        details = getDetails(e["place_id"])
        sugg = {}
        sugg["name"] = e["name"]
        sugg["img_url"] = details[:img_url]
        sugg["place_id"] = e["place_id"]
        sugg["latlong"] = e["geometry"]["location"]["lat"].to_s+","+e["geometry"]["location"]["lng"].to_s
        suggestions << sugg
      end
    end    
    suggestions
    #return array of POIS [{place_id, name}]
  end


#get directions for trips#new
  def getDirection(starting, array_of_place_ids)starting
    waypoints = array_of_place_ids
    waypoints = waypoints.join("|place_id:")
    params = URI.encode_www_form('origin' => "place_id:#{starting}", 'destination' => "place_id:#{starting}", 'mode' => 'walking', 'waypoints' => "place_id:#{waypoints}",'key' => APIKEY)
    link = TextDirectionBase + params
    response = HTTParty.get(link)
  end


#get images for point of interest
  def getDetails(place_id)
    query = URI.encode_www_form('placeid' => place_id, 'key' => APIKEY)
    link = TextDetailsBase + query
    response = HTTParty.get(link)
    name = response["result"]["name"]
    google_loc = response["result"]["geometry"]["location"]["lat"].to_s + "," + response["result"]["geometry"]["location"]["lng"].to_s
    if response["result"]["photos"]
      photoreference = response["result"]["photos"][0]["photo_reference"]
    else
      photoreference = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png"
    end
    img_url = getImage(photoreference)
    details_params = {name: name, latlong: google_loc, google_place: place_id, img_url: img_url}
  end

  
#get starting address from text search for bookmarks page(pois#index)
  def getStart(address)
    query = query = URI.encode_www_form('query' => address, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    place_id = response["results"][0]["place_id"]
  end

#get images for location#show
  def getImage(photoreference)
    # photoreference from output getDetails, set maxwidth to preferred size
    query = URI.encode_www_form('maxwidth' => "400", "photoreference" => photoreference, 'key' => APIKEY)
    img_url = PhotoBase + query
  end

end


