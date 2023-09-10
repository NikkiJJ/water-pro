class BathingSitesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_bathing_site, only: :show

  def index
    @bathing_sites = BathingSite.all
  end

  def show
  end

  private

  def set_bathing_site
    @bathing_site = BathingSite.find(params[:id])
  end
end
