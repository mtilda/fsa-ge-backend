class ReportsController < ApplicationController
  # GET /reports or /reports.json
  def index
    @reports = Report.all.take(100)
  end

  # GET /reports/1 or /reports/1.json
  def show
    @report = Report.find params[:id]
  end
end
