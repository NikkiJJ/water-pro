# favourites
class FavouritesController < ApplicationController
  def index
    @favourites = policy_scope(Favourite)
  end

  def new
    @favourite = Favourite.new(farvourite_params)
    authorize @favourite
  end

  def create
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    @favourite = Favourite.new(user: current_user, bathing_site: @bathing_site)
    authorize @favourite
    @favourite.save
    redirect_to bathing_site_path(@bathing_site)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    authorize @favourite
    @favourite.destroy
    redirect_back_or_to "/"
  end

  def update
    if current_user.signed_in?
      @favourite = Favourite.where(bathing_site: BathingSite.find(params[:bathing_site]), user: current_user)
      if @favourite == []
        Favourite.create(bathing_site: BathingSite.find(params[:bathing_site]), user: current_user)
      else
        @favourite.destroy.all
      end

    else
      link_to "Login", new_user_session_path
    end
  end

  private

  def farvourite_params
    params.require(:favourite).permit(:user, :bathing_site)
  end

end
