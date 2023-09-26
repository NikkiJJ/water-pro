class ReportReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new ]
  def new
    @report_review = ReportReview.new
  end

  def create
    @report_review = ReportReview.new(report_reviews_params)
    @report_review.review = Review.find(params[:review_id])

    authorize @report_review

    if @report_review.save
      redirect_to report_confirmation_page_path(@report_review)
    else
      render :new
    end
  end

  private

  def report_reviews_params
    params.require(:report_review).permit(:issue, :comment)  # Changed from :report_reviews
  end
end
