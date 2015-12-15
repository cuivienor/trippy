require 'google'

class PoisController < ApplicationController

  include Google

  def index
    @user = User.find_by(id: params[:user_id])
    @loc = Location.find_by(id: params[:location_id])
    @pois = @user.locations.find(location_id = @loc.id).pois

    if @pois
      array = []
      n = @pois.pluck(:latlong)
      n.each do |f|
        array << f
      end
      locs = array.join("|")
      @link = getStatic(locs)
    end
  end


  def show
  end


  def new	
  end
  

  def create
    @user = User.find(params[:user_id])
    @location = Location.find(params[:location_id])
    if params[:place_ids] then
         params[:place_ids].each do |place_id|
           poiAttr = getDetails(place_id)
           poiAttr[:location_id] = params[:location_id]
           poi = Poi.new(poiAttr)
           if poi.valid? 
             poi.save
             @user.pois << poi
           else
             poi = Poi.find_by(google_place: poi.google_place)
             @user.pois << poi if !@user.pois.exists?(id: poi.id)
           end
         end
         redirect_to user_location_pois_path(@user, @location)
    else
      redirect_to user_path(@user)
    end
  end
end
