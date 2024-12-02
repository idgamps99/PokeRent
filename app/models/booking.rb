class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :booking_start, :booking_end, presence: true
end
