class AvailabilityPolicy < ApplicationPolicy
  def create?
  	!user.blocked?
  end

  def update?
    !user.blocked? && record.user == user
  end

  def destroy?
  	record.user == user
  end
end
