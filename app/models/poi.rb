class Poi < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :trips
  belongs_to :location
  validates :google_place, uniqueness: true
  # add validation for checked boxes
end
