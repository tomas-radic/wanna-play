class Availability < ApplicationRecord

	# Validations
	validates :user_id, :date, :period, presence: true
	validates :user_id, uniqueness: { scope: [:date, :period] }

	# Relations
	belongs_to :user	

	enum period: [:all_day, :early_morning, :morning, :about_noon, :afternoon, :evening]

	# Scopes
	default_scope { where(occupied: false).where('date >= ?', Date.today).order(:date, :period) }

end
