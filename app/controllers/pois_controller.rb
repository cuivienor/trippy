require 'google'

class PoisController < ApplicationController

  include Google

  def index
    @user = User.find_by(id: params[:user_id])
    @loc = Location.find_by(id: params[:location_id])
    @pois = @user.locations.find(location_id= @loc.id).pois

    # @pois = User.find_by(id: params[:user_id]).find(Location.find_by(id: params[:location_id])).Poi.all

  end


  def show
    # @user = User.find_by(id: params[:user_id])
    # @loc = Location.find_by(id: params[:location_id])
    # @pois = @user.pois.all



  end


  def new	
  end


  def create
    
  end
end
