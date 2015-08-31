class AddColumnToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :directions, :text, array: true
  end
end
