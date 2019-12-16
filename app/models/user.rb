class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :patients
end