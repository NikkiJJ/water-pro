class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    true
  end

  def admin_dashboard?
    user.admin? ? true : false
  end
end
