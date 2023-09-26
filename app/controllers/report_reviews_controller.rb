class ReportReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new ]
  def new
    @report_reviews = ReportReview.new[report_reviews_params]
  end

  def create
    @report_reviews = ReportReview.new[report_reviews_params]
    @report.review = Review.find(params[:id])
    authorize @report_reviews
    if @report.save
      redirect_to report_confirmation_page_path(@report_reviews)
    else
      render :new
    end
  end

  private

  def report_reviews_params
    params.require(:report_reviews).permit(:issue, :comment)
  end
end
