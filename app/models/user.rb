class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :pois
  has_many :trips
  has_many :locations, through: :pois
  validates :username, presence: true, uniqueness: true
  validates :email, :first_name, :last_name, presence: true
  validates :password, length: { minimum: 7 }
  validates :password_confirmation, presence: true
end
