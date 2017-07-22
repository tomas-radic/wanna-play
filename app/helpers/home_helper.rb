module HomeHelper
	def user_info_for(availabilities)
		availabilities.map do |a| 
			note = note_for(a)
			user_info = "#{a.user.name}"
			user_info += " (#{a.user.phone_number})" unless a.user.phone_number.blank?
			user_info += "<i><small> - #{note}</small></i>" unless note.blank?
			user_info
		end.sort.join("<br/>").html_safe
	end
end
