class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :pois
  has_many :trips
  has_many :locations, through: :pois
end
