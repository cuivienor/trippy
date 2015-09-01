class Location < ActiveRecord::Base
  has_many :trips
  has_many :pois
  validates :google_place, uniqueness: true
end
