module ApplicationHelper
	def formatted_date(date)
		result = ''

		case date
		when Date.today
			result += 'dnes'
		when Date.tomorrow
			result += 'zajtra'
		else
			
			result += t("dates.days.#{date.strftime('%A').downcase}")
			result += date.strftime(', %-d ')
			result += t("dates.months.#{date.strftime('%B').downcase}")
		end
		
		result
	end
end
