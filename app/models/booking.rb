class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :booking_start, :booking_end, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if booking_end.present? && booking_start.present? && booking_end <= booking_start
      errors.add(:booking_end, "must be after the start date")
    end
  end
end
