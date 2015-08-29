class ChangeNameUserToPois < ActiveRecord::Migration
  def change
  	rename_table :users_to_pois, :pois_users
  end
end
