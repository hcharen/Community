class Item < ApplicationRecord
  validates :short_desc, presence: true
end
