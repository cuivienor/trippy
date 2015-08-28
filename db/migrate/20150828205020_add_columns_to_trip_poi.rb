class AddColumnsToTripPoi < ActiveRecord::Migration
  def change
  	add_column :trips_to_pois, :trip_id, :integer
  	add_column :trips_to_pois, :poi_id, :integer
  end
end
