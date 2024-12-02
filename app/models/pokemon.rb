class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, :ability, :pokemon_type, :price_per_day, presence: true
  validates :price_per_day, numericality: true
end
