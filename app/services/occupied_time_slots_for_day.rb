class OccupiedTimeSlotsForDay < Patterns::Service
  pattr_initialize :date, :courts

  def call
    result = {} 
    
    courts.each do |court|
      time_slot_occupation_info = {}

      court.occupations.where(date: date).each do |occupation|
        time_slot_occupation_info[occupation.time_slot_id] = occupation.id
      end

      result[court.id] = time_slot_occupation_info
    end

    result
  end
end
