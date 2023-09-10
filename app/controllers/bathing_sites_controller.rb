class BathingSitesController < ApplicationController

  def index
    @bathing_sites = BathingSite.all
  end

  def show
    @bathing_site = BathingSite.find(params[:id])
  end
end
