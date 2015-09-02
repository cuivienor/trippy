require 'httparty'
require 'rest-client'

module Google

  require 'uri'

  TextSearchBase = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
  TextDirectionBase = "https://maps.googleapis.com/maps/api/directions/json?"
  TextDetailsBase = "https://maps.googleapis.com/maps/api/place/details/json?"
  PoiSearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  AirportsAllBase = "http://iatacodes.org/api/v1/cities?"
  AirportBase = "http://iatacodes.org/api/v1/airports?"
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
    link = AirportsAllBase + query
    response1 = HTTParty.get(link)
    destination = response1["response"].find{|a| a["name"] == city.titleize}["code"]
    json = RestClient.post 'https://www.googleapis.com/qpxExpress/v1/trips/search?key=' + APIKEY,
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
    response2 = JSON.parse(json.body)
    tickets = []
    one_to_ten = (0..1).to_a
    one_to_ten.each do |num|
      option = {}
    airline_code = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["flight"]["carrier"]
    option["airline"] = response2["trips"]["data"]["carrier"].find{|a| a["code"]==airline_code}["name"]
    option["price"] = response2["trips"]["tripOption"][num]["saleTotal"]
    option["baggage_pieces"] = response2["trips"]["tripOption"][num]["pricing"][0]["segmentPricing"][0]["freeBaggageOption"][0]["bagDescriptor"][0]["count"]
    option["baggage_descr"] = response2["trips"]["tripOption"][0]["pricing"][0]["segmentPricing"][0]["freeBaggageOption"][0]["bagDescriptor"][0]["description"].join(',')
    
    option["departuretime_A"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["leg"][0]["departureTime"] 
    option["arrivaltime1_A"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["leg"][0]["arrivalTime"] 
    origin_A = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["leg"][0]["origin"]
    option["origin_A"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == origin_A}["name"]
    destination_A = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["leg"][0]["destination"]
    option["destination_A"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == destination_A}["name"]
    option["flightnr_A"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["flight"]["number"]
    option["terminal_A"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][0]["leg"][0]["originTerminal"]
    if option["terminal_A"] == nil
      option["terminal_A"] = "n/a"
    end

    if response2["trips"]["tripOption"][num]["slice"][0]["segment"][1] != nil
      option["departuretime_B"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["leg"][0]["departureTime"] 
      option["arrivaltime_B"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["leg"][0]["arrivalTime"] 
      origin_B = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["leg"][0]["origin"]
      option["origin_B"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == origin_B}["name"]
      destination_B = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["leg"][0]["destination"]
      option["destination_B"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == destination_B}["name"]
      option["flightnr_B"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["flight"]["number"] 
      option["terminal_B"] = response2["trips"]["tripOption"][num]["slice"][0]["segment"][1]["leg"][0]["originTerminal"]
      if option["terminal_B"] == nil
        option["terminal_B"] = "n/a"
      end
    end

    option["departuretime_C"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["leg"][0]["departureTime"] 
    option["arrivaltime1_C"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["leg"][0]["arrivalTime"] 
    origin_C = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["leg"][0]["origin"]
    option["origin_C"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == origin_C}["name"]
    destination_C = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["leg"][0]["destination"]
    option["destination_C"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == destination_C}["name"]
    option["flightnr_C"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["flight"]["number"]
    option["terminal_C"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][0]["leg"][0]["originTerminal"]
    if option["terminal_C"] == nil
      option["terminal_C"] = "n/a"
    end

    if response2["trips"]["tripOption"][num]["slice"][1]["segment"][1] != nil
      option["departuretime_D"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["leg"][0]["departureTime"] 
      option["arrivaltime_D"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["leg"][0]["arrivalTime"] 
      origin_D = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["leg"][0]["origin"]
      option["origin_D"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == origin_D}["name"]
      destination_D = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["leg"][0]["destination"]
      option["destination_D"] = response2["trips"]["data"]["airport"].find{|a| a["code"] == destination_D}["name"]
      option["flightnr_D"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["flight"]["number"] 
      option["terminal_D"] = response2["trips"]["tripOption"][num]["slice"][1]["segment"][1]["leg"][0]["originTerminal"]
      if option["terminal_D"] == nil
        option["terminal_D"] = "n/a"
      end
    end
    tickets << option
    end
    p tickets
    binding.pry
  end

  def getImage(photoreference)
    # photoreference from output getDetails, set maxwidth to preferred size
    query = URI.encode_www_form('maxwidth' => "400", "photoreference" => photoreference, 'key' => APIKEY)
    img_url = PhotoBase + query
  end

end


