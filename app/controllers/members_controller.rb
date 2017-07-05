class MembersController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: [:show, :index] 
  before_action :set_member, only: [:show]

  def show
    @reports = Report.where(character: @member.name)
  end

  def index
    config = Rails.application.config
    @members = Member.order('last_modified DESC, level DESC, rank ASC, name ASC').where('level >= ?', config.member_min_level).where('last_modified > ?', Time.now - 30.days)

    @classCounts = []
    for i in 1..12
      @classCounts.push(@members.where('character_class = ?', i).count)
    end

    @raceCounts = []
    @raceNames = ['Orc', 'Undead', 'Tauren', 'Troll', 'Goblin', 'Blood Elf', 'Pandaren']
    #races = ['Human', 'Orc', 'Dwarf', 'Night Elf', 'Undead', 'Tauren', 'Gnome', 'Troll', 'Goblin', 'Blood Elf', 'Draenei', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', 'Worgen', '?', 'Pandaren (Neutral)', 'Pandaren', 'Pandaren']
    
    for i in [2, 5, 6, 8, 9, 10, 26]
      @raceCounts.push(@members.where('race = ?', i).count)
    end

  end

  private
    def set_member
      @member = Member.find(params[:id])
    end
end
