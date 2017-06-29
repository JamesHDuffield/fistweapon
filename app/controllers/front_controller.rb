class FrontController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: :index

  def reset_cache
    puts "Starting jobs"
    Member.delete_all
    Event.delete_all
    Progression.delete_all
    Discord.delete_all
    EventUpdateJob.perform_later
    MemberUpdateJob.perform_later
    DiscordUpdateJob.perform_later
    ProgressionUpdateJob.perform_later
    redirect_to action: "index"
  end

  def index
    config = Rails.application.config

    @memberCount = Member.where('level >= ?', config.member_min_level).count

    @eventCount = Event.where('event_timestamp >= ?', Time.now - 1.day).count
    
    raids = config.raids
    @raidName = raids.first()
    progression = Progression.where(:raid => @raidName)

    @total = progression.count
    mythic = progression.where('mythic_kills > 0').count
    if mythic > 0
      @difficulty = 'Mythic'
      @kills = mythic
    else
      heroic = progression.where('heroic_kills > 0').count
      if heroic > 0
        @difficulty = 'Heroic'
        @kills = heroic
      else
        @difficulty = 'Normal'
        @kills = progression.where('normal_kills > 0').count
      end
    end

    if @total > 0
      @percentageProgress = @kills * 100 / @total
    else
       @percentageProgress = 0
    end

    @reportCount = Report.count
    @discord = Discord.order('discord_timestamp DESC').take(config.discord_max_messages)
  end
end
