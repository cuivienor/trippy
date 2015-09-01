class Trip < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :pois
  belongs_to :location
end
