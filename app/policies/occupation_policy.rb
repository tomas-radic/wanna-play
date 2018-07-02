class OccupationPolicy < ApplicationPolicy
  def create_multiple?
    can_manage_occupations?
  end

  def destroy?
    can_manage_occupations?
  end

  private

  def can_manage_occupations?
    user.present? && user.has_role?('operator')
  end
end
