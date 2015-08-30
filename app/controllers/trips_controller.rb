
class TripsController < ApplicationController

    private
      def trip_params
        params.require(:trip).permit(:map_image,:user_id, :location_id)
      end
end

