class ReleaseTimeSlot < Patterns::Service
  pattr_initialize :court_id, :date, :time_slot_id

  def call
    release_time_slot!
  end

  private

  def release_time_slot!
    Occupation.find_by!(court: court, date: date, time_slot: time_slot).destroy
  end

  def court
    @court ||= Court.find(court_id)
  end

  def time_slot
    @time_slot ||= TimeSlot.find(time_slot_id)
  end
end
