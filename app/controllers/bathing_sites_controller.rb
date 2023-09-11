class BathingSitesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_bathing_site, only: :show

  def index
    @bathing_sites = BathingSite.all
  end

  def show
  end

  def new
    @bathing_site = BathingSite.new
  end

  def create
    @bathing_site = BathingSite.new(bathing_params)
  end
  private

  def set_bathing_site
    @bathing_site = BathingSite.find(params[:id])
  end

  def bathing_params
    params.require(:bathing_site).permit(:pollution_level, :site_name, :tide, :region)
  end

end
