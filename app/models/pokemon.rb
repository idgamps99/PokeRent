class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :ability, :pokemon_type, :price_per_day, presence: true
  validates :price_per_day, numericality: true

  # Search by name and pokemon type
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: {prefix: true}
    }

  pg_search_scope :search_by_type,
  against: [:pokemon_type],
  using: {
    tsearch: {prefix: true}
  }
end
