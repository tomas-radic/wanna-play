class UserMailer < ApplicationMailer
	default to: 'tomas.radic@gmail.com'

	def user_created(user)
		@user = user
		mail(subject: "wanna-play: created user #{@user.name}")
	end

	def user_destroyed(user)
		@user = user
		mail(subject: "wanna-play: destroyed user #{@user.name}")
	end
end
