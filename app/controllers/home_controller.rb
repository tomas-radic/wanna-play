class HomeController < ApplicationController
  def index
  	@availabilities = Availability.all.where('date < ?', 1.month.from_now).includes(:user)
  end
end
