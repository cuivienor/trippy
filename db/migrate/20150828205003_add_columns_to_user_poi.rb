class AddColumnsToUserPoi < ActiveRecord::Migration
  def change
  	add_column :users_to_pois, :user_id, :integer
  	add_column :users_to_pois, :poi_id, :integer
  	add_index :users_to_pois, :user_id
  	add_index :users_to_pois, :poi_id
  end
end
