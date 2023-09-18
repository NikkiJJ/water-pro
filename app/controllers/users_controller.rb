class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favourites = @user.favourites.all
    authorize @user
  end
end
