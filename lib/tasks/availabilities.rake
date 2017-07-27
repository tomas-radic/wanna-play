namespace :availabilities do
  
  desc 'Destroys all availabilities planned for the yesterday or older'
  task destroy_passed: :environment do
    puts "destroyed #{Availability.passed.destroy_all.count} availabilities"
  end

  desc 'Destroys all availabilities that belong to blocked users'
  task destroy_blocked: :environment do
  	puts "destroyed #{Availability.blocked.destroy_all.count} availabilities"
  end
end
