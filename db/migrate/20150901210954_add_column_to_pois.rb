class AddColumnToPois < ActiveRecord::Migration
  def change
    add_column :pois, :img_url, :string
  end
end
