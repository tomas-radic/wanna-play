class HomeController < ApplicationController
  def index
  	@availabilities = Availability.unblocked.upcoming.includes(:user)
  end
end
