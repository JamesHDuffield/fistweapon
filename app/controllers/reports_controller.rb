class ReportsController < ApplicationController
  def new
    @report = Report.new
    @members = Member.order('name').all
  end

  def create
  end

  def edit
  end
end
