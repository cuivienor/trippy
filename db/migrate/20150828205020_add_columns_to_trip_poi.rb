class AddColumnsToTripPoi < ActiveRecord::Migration
  def change
  	add_column :trips_to_pois, :trip_id, :integer
  	add_column :trips_to_pois, :poi_id, :integer
  	add_index :trips_to_pois, :trip_id
  	add_index :trips_to_pois, :poi_id
  end
end
