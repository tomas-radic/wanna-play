module HomeHelper
	def user_info_for(availabilities)
		availabilities.map do |a| 
			user_info = "#{a.user.name}"
			user_info += " (#{a.user.phone_number})" unless a.user.phone_number.blank?
			user_info
		end.join(', ')
	end
end
