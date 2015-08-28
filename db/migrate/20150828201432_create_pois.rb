class CreatePois < ActiveRecord::Migration
  def change
    create_table :pois do |t|
      t.string :name
      t.string :google_place
      t.string :latlong
    end
  end
end
