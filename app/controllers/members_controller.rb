class MembersController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: [:show, :index] 
  before_action :set_member, only: [:show]

  def show
    @reports = Report.where(character: @member.name)
  end

  def index
    config = Rails.application.config
    @members = Member.order('level DESC, rank ASC, last_modified DESC, name ASC').where('level >= ?', config.member_min_level).where('last_modified > ?', Time.now - 30.days)

    @classCounts = [];
    for i in 1..12
      @classCounts.push(@members.where('character_class = ?', i).count)
    end

    @raceCount = [];
    for i in 1..26
      @raceCount.push(@members.where('race = ?', i).count)
    end

  end

  private
    def set_member
      @member = Member.find(params[:id])
    end
end
