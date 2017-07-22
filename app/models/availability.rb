class Availability < ApplicationRecord

	# Validations
	validates :user_id, :date, :period, presence: true
	validates :user_id, uniqueness: { scope: [:date, :period] }
	validates :note, length: { maximum: Rails.configuration.max_availability_note_length }

	# Relations
	belongs_to :user	

	enum period: [:all_day, :early_morning, :morning, :about_noon, :afternoon, :evening]

	# Scopes
	scope :current, -> { where(occupied: false).where('date >= ?', Date.today).order(:date, :period) }

	before_validation :strip_whitespaces


	private

	def strip_whitespaces
		self.note.strip!
	end
end
