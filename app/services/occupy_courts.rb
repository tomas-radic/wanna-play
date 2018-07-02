class OccupyCourts < Patterns::Service
  pattr_initialize :user_id, :date, :occupations

  def call
    create_occupations!
  end

  private

  def create_occupations!
    ActiveRecord::Base.transaction do
      courts.each do |court|
        occupy!(court)
      end
    end
  end

  def occupy!(court)
    court.time_slots.find(occupations[court.id]).each do |time_slot|
      court.occupations.create!(user: user, date: date, time_slot: time_slot)
    end
  end

  def courts
    @courts ||= CourtsQuery.call.includes(:time_slots).find(court_ids)
  end

  def court_ids
    occupations.keys
  end

  def time_slots_for(court)
    court.time_slots
  end

  def user
    @user ||= UsersQuery.call.find(user_id)
  end
end
