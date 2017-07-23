class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @availabilities = current_user.availabilities.current
  end

  def new
    @availability = current_user.availabilities.build(date: Date.today, period: :all_day)
  end

  def create
    @availability = current_user.availabilities.build(availability_params)
    authorize @availability

    if @availability.save
      flash[:success] = t('.success')
    else
      set_error_message
    end

    redirect_to availabilities_path
  end

  def edit
    @availability = current_user.availabilities.current.unblocked.find(params[:id])
  end

  def update
    @availability = current_user.availabilities.current.unblocked.find(params[:id])
    authorize @availability

    if @availability.update(availability_params)
      flash[:success] = t('.success')
    else
      set_error_message
    end

    redirect_to availabilities_path
  end

  def destroy
    availability = current_user.availabilities.current.find(params[:id])
    authorize availability
    availability.destroy
    @availabilities = current_user.availabilities.current
  end


  private

  def availability_params
    params.require(:availability).permit(:date, :period, :note)
  end

  def set_error_message
    flash[:error] = t('.error')
    already_exists_error = @availability.errors.details[:user_id].to_a
    
    if already_exists_error.any?
      if already_exists_error.first[:error].eql?(:taken)
        flash[:error] = t('.record_already_exists')
      end
    end
  end
end
