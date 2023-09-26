class ReportReviewsController < ApplicationController
  def new
    @report_review = ReportReview.new
    @review = Review.find(params[:review_id])
    authorize @report_review
  end

  def create
    @report_review = ReportReview.new(report_reviews_params)
    @report_review.review = Review.find(params[:review_id])

    authorize @report_review

    @report_review.save
    # if @report_review.save
    #   redirect_to report_confirmation_page_path(@report_review)
    # else
    #   render :new
    # end
  end

  private

  def report_reviews_params
    params.require(:report_review).permit(:issue, :comment)
  end
end
