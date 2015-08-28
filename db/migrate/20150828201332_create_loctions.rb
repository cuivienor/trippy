class CreateLoctions < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :google_place
      t.string :latlong
    end
  end
end
