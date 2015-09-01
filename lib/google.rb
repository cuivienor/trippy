require 'httparty'
require 'rest-client'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  TextDetailsBase = "https://maps.googleapis.com/maps/api/place/details/json?"
  PoiSearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  AirportCodeBase = "http://iatacodes.org/api/v1/cities?"
  PhotoBase = "https://maps.googleapis.com/maps/api/place/photo?"
  APIKEY = ENV['GOOGLEAPIKEY']
  FLIGHTKEY = ENV['IATAKEY']

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

  def getDirection(starting,array_of_place_ids)
    waypoints = array_of_place_ids.split(" ")
    waypoints = waypoints.join("|place_id:")
    params = URI.encode_www_form('origin' => "place_id:#{starting}", 'destination' => "place_id:#{starting}", 'mode' => 'walking', 'waypoints' => "optimize=true|place_id:#{waypoints}", 'sensor' => false, 'key' => APIKEY)
    link = TextDirectionBase + params
    response = HTTParty.get(link)
  end


  def getDetails(place_id)
    query = URI.encode_www_form('placeid' => place_id, 'key' => APIKEY)
    link = TextDetailsBase + query
    response = HTTParty.get(link)
    name = response["result"]["name"]
    photoreference = response["result"]["photos"]["photo_reference"]
    google_loc = response["result"]["geometry"]["location"]["lat"].to_s + "," + response["result"]["geometry"]["location"]["lng"].to_s
    details_params = {name: name, latlong: google_loc, google_place: place_id}
  end
  
  def getStart(address)
    query = query = URI.encode_www_form('query' => address, 'key' => APIKEY)
    link = TextSearchBase + query
    response = HTTParty.get(link)
    place_id = response["results"][0]["place_id"]
  end

  def getTickets(city)
    # TBD -> dates, dynamic origin, more pricing e.g 5 options 
    query = URI.encode_www_form('api_key' => FLIGHTKEY)
    link = AirportCodeBase + query
    response = HTTParty.get(link)
    destination = response["response"].find{|a| a["name"] == city.titleize}["code"]
    response = RestClient.post 'https://www.googleapis.com/qpxExpress/v1/trips/search?key=' + APIKEY,
             {
               request: {
                 passengers: {
                   adultCount: 1
                 },
                 slice: [
                   {
                     origin: "JFK",
                     destination: destination,
                     date: "2015-10-14"
                   },
                   {
                     origin: destination,
                     destination: "JFK",
                     date: "2015-11-14"
                   }
                 ]
               }
             }.to_json,
             :content_type => :json
    ticket = JSON.parse(response.body)
    pricing1 = ticket["trips"]["tripOption"][0]["pricing"][0]["saleTotal"]
    binding.pry
  end

  def getImage(photoreference)
    # photoreference from output getDetails, set maxwidth to preferred size
    query = URI.encode_www_form('maxwidth' => "400", "photoreference" => photoreference, 'key' => APIKEY)
    img_url = PhotoBase + query
  end

end


