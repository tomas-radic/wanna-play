class HomeController < ApplicationController
  def index
  	@availabilities = Availability.all
  end
end
