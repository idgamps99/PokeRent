class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :ability, :pokemon_type, :price_per_day, :address, presence: true
  validates :price_per_day, numericality: true
end
