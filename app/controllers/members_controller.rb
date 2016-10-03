class MembersController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: :show 
  before_action :set_member, only: [:show]

  def show
    @reports = Report.where(character: @member.name)
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end
end
