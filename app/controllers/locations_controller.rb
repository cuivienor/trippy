require 'google'

class LocationsController < ApplicationController

    include Google

    def index
    
    end

    def create
        name = params[:q]
        location = Location.new(getLocation(name))
        if location.valid?
          location.save
        else
          location = Location.find_by(google_place: location.google_place)
        end

        # user = User.find(params[:user_id])
        redirect_to user_location_path(params[:user_id], location)

    end


#POI suggestions page
    def show
        @user_id = params[:user_id]
        @location = Location.find(params[:id])
        @suggestions = getPois(@location.latlong)

        if @suggestions
            array = []
            @suggestions.each do |sugg|
               s = sugg["latlong"]
               array << s
           end
           suggs = array.join("|")
           @link = getStatic(suggs)
        end
    


    end

    private
      def location_params
        params.require(:location).permit(:name,:google_place, :latlong, :user_id)
      end
end
