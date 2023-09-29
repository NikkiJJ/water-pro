class ReportReviewsController < ApplicationController
  def new
    @report_review = ReportReview.new
    @review = Review.find(params[:review_id])
    authorize @report_review
  end

  def create
    @report_review = ReportReview.new(report_reviews_params)
    @review = Review.find(params[:review_id])
    @report_review.review = @review
    authorize @report_review

    if @report_review.save
      redirect_to confirmed_review_path(@report_review)
    else
      render :new
    end
  end

  def confirmation
    @report_review = ReportReview.find(params[:id])
    authorize @report_review
  end

  def destroy
    # for the "Dismiss" button - to delete the report of the review
    @report_review = ReportReview.find(params[:id])
    authorize @report_review
    @report_review.destroy
    redirect_to admin_dashboard_user_path
  end

  private

  def report_reviews_params
    params.require(:report_review).permit(:issue, :comment)
  end
end
