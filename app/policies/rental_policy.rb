class RentalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def create?
    user != record.user
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user.admin
  end

  private

  def user_is_owner_or_admin?
    # El record sobre el cual autorice
    # current_user => user
    # @restaurant => record
    user == record.user || user.admin
  end
end
