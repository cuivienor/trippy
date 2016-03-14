class AddForeignKeyToLocations < ActiveRecord::Migration
  def change
    add_foreign_key :trips, :locations
  end
end
