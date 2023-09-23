class ReportsController < ApplicationController

  def index
    @reports = policy_scope(BathingSite).all
  end

  # def new
  #   @bathing_site = BathingSite.find(params[:bathing_site_id])
  #   @report = Report.new(bathing_site: @bathing_site)
  #   authorize @report
  # end

  def create
    @report = Report.new(report_params)
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    @report.bathing_site = @bathing_site
    authorize @report

    if @report.save
      redirect_to report_confirmation_page_path(@report)
    else
      render :new
    end
  end

  def confirmation_page
    @report = Report.find(params[:id])
    authorize @report
  end

  private

  def report_params
    params.require(:report).permit(:issue, :comment)
  end
end
