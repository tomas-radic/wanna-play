class Occupation < ApplicationRecord

  validates :date, presence: true
  validates :court_id, uniqueness: { scope: [:date, :time_slot_id] }

  belongs_to :user
  belongs_to :court
  belongs_to :time_slot

end
