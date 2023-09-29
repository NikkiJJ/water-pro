class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    @review.bathing_site = @bathing_site
    authorize @review
    @review.user = current_user
    @review.date = Date.today
    if @review.save
      redirect_to bathing_site_path(@bathing_site)
    else
      render :new
    end
  end

  def index
    @reviews = policy_scope(Review).where(bathing_site: bathing_site)
    @bathing_site = BathingSite.find(params[:bathing_site_id])
  end

  def show
    @review = Review.find(params[:id])
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @review
  end

  def edit
    @review = Review.find(params[:id])
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @review
  end

  def update
    @review = Review.find(params[:id])
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @review
    @review.update(review_params)
    redirect_to bathing_site_reviews_path(@bathing_site)
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to admin_dashboard_user_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :ratings)
  end
end
