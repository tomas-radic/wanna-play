class AvailabilityPolicy
  attr_reader :user, :availability

  def initialize(user, availability)
    @user = user
    @availability = availability
  end

  def create?
  	!user.blocked?
  end

  def update?
    !user.blocked? && availability.user == user
  end

  def destroy?
  	availability.user == user
  end
end
