class AddLocationRefToTrips < ActiveRecord::Migration
  def change
  	add_reference :trips, :location, index: true, foreign_key: true
  end
end
