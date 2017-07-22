module AvailabilitiesHelper
	def note_for(availability)
		return '' if availability.note.blank?
		"\"#{availability.note.strip.slice(0...Rails.configuration.max_availability_note_length)}\""
	end
end
