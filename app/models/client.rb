class Client < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :locations through: :appointments 
end
