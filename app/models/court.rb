class Court < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :court_to_time_slots, dependent: :destroy
  has_many :time_slots, through: :court_to_time_slots
  has_many :occupations, dependent: :destroy

  scope :enabled, -> { where(enabled: true) }
end
