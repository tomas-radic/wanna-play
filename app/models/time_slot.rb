class TimeSlot < ApplicationRecord

  validates :order_key, uniqueness: true
  validates :order_key, 
      :label_begin_time, 
      :label_end_time,
      presence: true

  has_many :court_to_time_slots, dependent: :destroy
  has_many :courts, through: :court_to_time_slots
end
