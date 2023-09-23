class ReportsController < ApplicationController

  def index
    @reports = policy_scope(Report).all
  end

  # def new
  #   @bathing_site = BathingSite.find(params[:bathing_site_id])
  #   @report = Report.new(bathing_site: @bathing_site)
  #   authorize @report
  # end

  def show
    @report = Report.find(params[:id])
    authorize @report
  end

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

  def update
    @report = Report.find(params[:id])
    authorize @report
    @report.update(confirmation: true)
    redirect_to reports_path
  end

  def update_confirmation
    @report = Report.find(params[:id])
    authorize @report
    @report.update(confirmation: true)
    redirect_to reports_path
  end

  def destroy
    @report = Report.find(params[:id])
    authorize @report
    @report.destroy

    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:issue, :comment)
  end
end
