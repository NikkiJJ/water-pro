class BathingSitesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_bathing_site, only: %i[show edit update destroy]

  def index
    @bathing_sites = policy_scope(BathingSite).all

    if params[:query].present?
      @bathing_sites = BathingSite.search_by_site_name(params[:query])
    else
      @bathing_sites = BathingSite.all
    end

    @markers = @bathing_sites.geocoded.map do |bathing_site|
      {
        lat: bathing_site.latitude,
        lng: bathing_site.longitude
      }
    end
    @bathing_site = @bathing_sites.first
  end

  def show
    authorize @bathing_site
    @favourite = Favourite.find_by(user: current_user, bathing_site: @bathing_site)
    @reviews = @bathing_site.reviews.all
    @new_report = Report.new(bathing_site: @bathing_site)
    @reports = @bathing_site.reports
  end

  def new
    authorize @bathing_site
    @bathing_site = BathingSite.new
  end

  def create
    @bathing_site = BathingSite.new(bathing_params)
    @bathing_site.user = current_user
    authorize @bathing_site
    if @bathing_site.save
      redirect_to bathing_site_path(@bathing_site)
    else
      render :new
    end
  end

  def edit
    authorize @bathing_site
  end

  def update
    authorize @bathing_site
    @bathing_site.update(bathing_site_params)
    redirect_to bathing_site_path(@bathing_site)
  end

  def destroy
    authorize @bathing_site
    @bathing_site.user = current_user
    @bathing_site.destroy

    redirect_to bathing_sites_path(@bathing_sites)
  end

  private

  def set_bathing_site
    @bathing_site = BathingSite.find(params[:id])
  end

  def bathing_params
    params.require(:bathing_site).permit(:pollution_level, :site_name, :tide, :region)
  end
end
