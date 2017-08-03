class Availability < ApplicationRecord

	# Validations
	validates :user_id, :date, :period, presence: true
	validates :user_id, uniqueness: { scope: [:date, :period, :occupied_since] }, unless: :occupied?
	validates :note, length: { maximum: Rails.configuration.max_availability_note_length }

	# Relations
	belongs_to :user	

	enum period: [:all_day, :early_morning, :morning, :about_noon, :afternoon, :evening]

	# Scopes
	scope :upcoming, -> { 
		where(occupied_since: nil).where('date >= ? and date < ?', Date.today, 2.weeks.from_now)
		.order(:date, :period) 
	}
	scope :current, -> { where(occupied_since: nil).where('date >= ?', Date.today).order(:date, :period) }
	scope :passed, -> { where('date < ?', Date.today) }
	scope :unblocked, -> { joins(:user).where('users.blocked is false') }
	scope :blocked, -> { joins(:user).where('users.blocked is true') }

	# Callbacks
	before_validation :strip_whitespaces
	before_validation :set_default_values


	private

	def strip_whitespaces
		self.note.strip! unless self.note.blank?
	end

	def set_default_values
		self.autocancel ||= false
	end

	def occupied?
		self.occupied_since.present?
	end
end
