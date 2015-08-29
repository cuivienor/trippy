class Location < ActiveRecord::Base
  has_many :trips
end
