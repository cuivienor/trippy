class AddLocationRefToPois < ActiveRecord::Migration
  def change
    add_reference :pois, :location, index: true, foreign_key: true
  end
end
