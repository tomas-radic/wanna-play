class OccupationsController < ApplicationController

  def index
    @date = session[:date] || Date.today
    @user_id = session[:user_id]
    @active_tab = session[:active_tab]

    session.delete(:date)
    session.delete(:user_id)
    session.delete(:active_tab)

    @courts = CourtsQuery.call.includes(occupations: :user)
    @occupied_time_slots = OccupiedTimeSlotsForDay.call(@date, @courts).result
  end

  def create_multiple
    authorize Occupation

    session[:date] = params[:date]
    session[:user_id] = params[:user_id]
    session[:active_tab] = params[:active_tab]

    begin
      OccupyCourts.call(
        params[:user_id], 
        params[:date],
        ExtractOccupationsFromParams.result_for(params: params)
      )
    rescue ActiveRecord::RecordInvalid
      flash[:error] = t('.error')
    end

    

    redirect_to occupations_path
  end

  def destroy
    @occupation = Occupation.find(params[:id])
    authorize @occupation

    @court = @occupation.court
    @date = @occupation.date
    @time_slot = @occupation.time_slot
    @element_id = ".time_slot_row_#{@court.id}_#{@time_slot.id}"
    @occupation.destroy

    @courts = CourtsQuery.call
    @occupied_time_slots = OccupiedTimeSlotsForDay.call(@date, @courts).result
  end
end
