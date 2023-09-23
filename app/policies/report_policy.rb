class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.admin? ? scope.all : scope.none
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def update?
    user.admin? ? true : false
  end

  def destroy?
    user.admin? ? true : false
  end

  def confirmation_page?
    true
  end
end
