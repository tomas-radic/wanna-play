namespace :demo do
  
  desc 'Generates fake demo availabilities used to be shown on the page while season is over'
  task generate_availabilities: :environment do
    MAX_DEMO_USERS_COUNT = 10
    
    demo_users = User.where(blocked: false).demos
    demo_users_to_create = MAX_DEMO_USERS_COUNT - demo_users.count
    demo_users_to_create = 0 if demo_users_to_create < 0

    if demo_users_to_create > 0
      puts "Creating demo users..."
      demo_users_to_create.times do
        user = User.new(
          email: Faker::Internet.email, 
          name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
          phone_number: Faker::PhoneNumber.cell_phone,
          password: 'iDontTellYou:-)', 
          password_confirmation: 'iDontTellYou:-)'
        )
        
        if user.add_role('demo')  # this actually saves the user
          puts "\tDemo user #{user.email} created."
        else
          puts "\tFailed to create demo user #{user.email}\n#{user.errors.inspect}"
        end
      end
    end

    demo_users = User.where(blocked: false).demos
    Availability.where(user_id: demo_users.ids).destroy_all

    puts "\nCreating availabilities for #{demo_users.count} demo users..."
    demo_users.each do |user|
      puts "\t#{user.email}"
      avs_to_create = rand(1..3)

      avs_to_create.times do
        random_day = Date.today + rand(0..14).days
        periods_count = Availability.periods.count  # we assume to have some periods defined in Availability model
        random_period = Availability.periods.select { |k, v| v == rand(0...periods_count) }.keys.first

        user.availabilities.create(date: random_day, period: random_period)
      end

      puts "\tcreated #{avs_to_create} " + 'availability'.pluralize(avs_to_create)
    end
  end

  desc 'Destroys all demo users'
  task destroy_demo_users: :environment do
    puts "Destroyed #{User.demos.destroy_all.count} demo users."
  end
end
