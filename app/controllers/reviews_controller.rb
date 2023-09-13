class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @bathing_site = bathing_site.find(params[:bathing_site_id])
    authorize @review
  end

  def index
    @reviews = policy_scope(Review).all
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :ratings)
  end
end
