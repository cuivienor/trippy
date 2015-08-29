class Trip < ActiveRecord::Base
  belongs_to :users
  has_and_belongs_to_many :pois
  belongs_to :location
end
