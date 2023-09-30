class ReportReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.admin? ? scope.all : scope.none
    end
  end

  def new?
    true
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

  def confirmation?
    true
  end
end
