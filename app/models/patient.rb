class Patient < ActiveRecord::Base

  validates :name, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true


  belongs_to :user
  has_many :appointments
end
