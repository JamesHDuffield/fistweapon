class FrontController < ApplicationController
  config = Rails.application.config
  http_basic_authenticate_with name: config.report_username, password: config.report_password, except: :index

  def reset_cache
    ApiRequest.delete_all
    Member.delete_all
    Event.delete_all
    Progression.delete_all
    Discord.delete_all
    redirect_to action: "index"
  end

  def index
    config = Rails.application.config

    EventUpdateJob.perform_later
    DiscordUpdateJob.perform_later
    MemberUpdateJob.perform_later
    ProgressionUpdateJob.perform_later

    @members = Member.order('level DESC, rank ASC, name ASC').where('level >= ?', config.member_min_level)
    @events = Event.order('event_timestamp DESC').take(config.event_max_items)
    @raids = config.raids
    @progression = Progression.where(:raid => @raids).group_by { |p| p.raid }
    @guild = Guild.find_by(name: config.guild_name)
    @discord = Discord.order('discord_timestamp DESC').take(config.discord_max_messages)
  end
end
