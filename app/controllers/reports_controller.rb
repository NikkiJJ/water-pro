class ReportsController < ApplicationController

  def new
    @report = Report.new
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @report
  end

  def create
    @report = Report.new(report_params)
    @bathing_site = BathingSite.find(params[:bathing_site_id])
    authorize @report

    if @report.save
      redirect_to report_confirmation_page
    else
      render :new
    end
  end

  def confirmation_page
    authorize @report
  end

  private

  def report_params
    params.require(:report).permit(:issue, :comment)
  end
end
