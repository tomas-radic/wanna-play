class HomeController < ApplicationController
  def index
  	@availabilities = Availability.unblocked.upcoming.includes(:user)
    @availabilities = @availabilities.where.not(user_id: User.demos.ids) unless Rails.configuration.demo_mode
  end
end
