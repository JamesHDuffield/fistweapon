class MembersController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: [:show, :index] 
  before_action :set_member, only: [:show]

  def show
    @reports = Report.where(character: @member.name)
  end

  def index
    config = Rails.application.config
    @members = Member.order('level DESC, rank ASC, name ASC').where('level >= ?', config.member_min_level)
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end
end
