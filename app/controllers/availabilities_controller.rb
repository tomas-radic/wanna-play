class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @availabilities = current_user.availabilities
  end

  def new
    @availability = current_user.availabilities.build(date: Date.today, period: :all_day)
  end

  def create
    @availability = current_user.availabilities.build(availability_params)
    if @availability.save
      flash[:success] = 'success (temp)'
    else
      flash[:error] = 'error (temp)'
    end

    redirect_to availabilities_path
  end

  def edit
    @availability = current_user.availabilities.find(params[:id])
  end

  def update
    @availability = current_user.availabilities.find(params[:id])

    if @availability.update(availability_params)
      flash[:notice] = 'success (temp)'
    else
      flash[:alert] = 'error (temp)'
    end

    redirect_to availabilities_path
  end

  def destroy
    current_user.availabilities.find(params[:id]).destroy
    @availabilities = current_user.availabilities
  end


  private

  def availability_params
    params.require(:availability).permit(:date, :period)
  end
end
