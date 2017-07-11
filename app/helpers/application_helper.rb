module ApplicationHelper
	def formatted_date(date)
		result = ''

		case date
		when Date.today
			result += t('dates.today')
		when Date.tomorrow
			result += t('dates.tomorrow')
		else
			result += t("dates.days.#{date.strftime('%A').downcase}")
			result += date.strftime(', %-d ')
			result += t("dates.months.#{date.strftime('%B').downcase}")
		end
		
		result
	end
end
