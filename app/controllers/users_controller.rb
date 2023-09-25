# users controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favourites = @user.favourites.includes(:bathing_site)
    authorize @user
  end
end
