class HomeController < ApplicationController
  def index
  	@availabilities = Availability.current.unblocked
  		.where('date < ?', 1.month.from_now).includes(:user)
  end
end
