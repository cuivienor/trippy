class ChangeNameTripToPois < ActiveRecord::Migration
  def change
  	rename_table :trips_to_pois, :pois_trips
  end
end
