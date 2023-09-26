# users controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favourites = @user.favourites.includes(:bathing_site)
    authorize @user
  end

  def user_params
    params.require(:user).permit(:photo)
  end
end
