# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.destroy_all

# Create 10 users
puts "\nCreating users..."

10.times do |i|
	email = Faker::Internet.email
	email.gsub!('@', "#{i + 1}@")
	user = User.new(
		email: email, 
		name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
		phone_number: Faker::PhoneNumber.cell_phone,
		password: 'iDontTellYou:-)', 
		password_confirmation: 'iDontTellYou:-)'
	)
	
	if user.save
		puts "\tUser #{user.email} created."
	else
		puts "\tFailed to create user #{user.email}\n#{user.errors.inspect}"
	end
end

# Create some availabilities for users.
# Count users, create availabilities for lets say 2/3 of them, 1-3 for each in upcoming week.
users_with_availabilities = User.all.limit((User.all.count * 0.67).ceil)
puts "\nCreating availabilities for #{users_with_availabilities.count} users..."

users_with_availabilities.each do |user|
	puts "\t#{user.email}"
	avs_to_create = rand(1..3)

	avs_to_create.times do
		random_day = Date.today + rand(0..7).days
		periods_count = Availability.periods.count 	# we assume to have some periods defined in Availability model
		random_period = Availability.periods.select { |k, v| v == rand(0...periods_count) }.keys.first

		user.availabilities.create(date: random_day, period: random_period)
	end

	puts "\tcreated #{avs_to_create} " + 'availability'.pluralize(avs_to_create)
end
