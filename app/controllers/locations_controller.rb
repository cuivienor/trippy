require 'google'

class LocationsController < ApplicationController
skip_before_action :require_login, only: [:index, :create, :show]    

    include Google

    def index
        @user = User.find params[:id]
        @location = params[:location]
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

    def show
        @user_id = params[:user_id]

        @location = Location.find(params[:id])

        @suggestions = getPois(@location.latlong)

        # binding.pry

        # redirect_to user_location_pois_path(@user, @location)

    end

    private
      def location_params
        params.require(:location).permit(:name,:google_place, :latlong, :user_id)
      end
end
