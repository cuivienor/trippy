class AddLocationRefToPois < ActiveRecord::Migration
  def change
    add_reference :pois, :locations, index: true, foreign_key: true
  end
end
