class ReportsController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password
  before_action :set_report, only: [:edit, :update, :destroy]

  def new
    @report = Report.new
    @report.character = params[:character]
    @members = Member.order('name').all
  end

  def edit
    @members = Member.order('name').all
  end

  def create
    @report = Report.new(report_params)
    @report.posted = Time.current
    @member = Member.find_by(name: @report.character)
    respond_to do |format|
      if @report.save
        format.html { redirect_to @member, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report/1
  # PATCH/PUT /report/1.json
  def update
    @member = Member.find_by(name: @report.character)
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @member, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report/1
  # DELETE /report/1.json
  def destroy
    @member = Member.find_by(name: @report.character)
    @report.destroy
    respond_to do |format|
      format.html { redirect_to @member, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:character, :dkp, :title, :content)
    end
end
