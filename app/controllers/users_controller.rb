# users controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favourites = @user.favourites.includes(:bathing_site)
    authorize @user
  end

  def admin_dashboard
    @user = User.find(params[:id])
    @report_reviews = policy_scope(ReportReview).all
    @reports = policy_scope(Report).all
    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end
