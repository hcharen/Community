class Item < ApplicationRecord

  has_attached_file :image
  validates :short_desc, presence: true
end
