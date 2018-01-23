class Location < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :clients through: :lessons
end
