class AddStopsColumnToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :stops, :text, array: true
  end
end
