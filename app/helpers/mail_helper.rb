module MailHelper
	require 'sendgrid-ruby'
	include SendGrid

	ADMIN_EMAIL = 'tomas.radic@gmail.com'
	DEFAULT_FROM = 'info@wanna-play.com'

	def self.send_mail(sender, recipient, subject, body)
		from = Email.new(email: sender)
		to = Email.new(email: recipient)

		content = Content.new(type: 'text/html', value: body)
		mail = Mail.new(from, subject, to, content)

		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.headers
	end

	def self.user_created(user)
		content = "<!DOCTYPE html><html><head><meta content='text/html; charset=UTF-8' http-equiv='Content-Type' /></head>"\
			"<body><h1>Created user #{user.name}</h1><p>email: #{user.email}<br/>phone number: #{user.phone_number}"\
			"</p></body></html>"
		send_mail(DEFAULT_FROM, ADMIN_EMAIL, "wanna-play: created user #{user.name}", content)
	end
end
