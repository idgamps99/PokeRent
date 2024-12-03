class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :name, :ability, :pokemon_type, :price_per_day, presence: true
  validates :price_per_day, numericality: true
end
