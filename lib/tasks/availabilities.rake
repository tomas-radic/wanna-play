namespace :availabilities do
  
  desc 'Destroys all availabilities planned for the yesterday or older'
  task destroy_passed: :environment do
    Availability.passed.destroy_all
  end

  desc 'Destroys all availabilities that belong to blocked users'
  task destroy_blocked: :environment do
  	Availability.blocked.destroy_all
  end
end
