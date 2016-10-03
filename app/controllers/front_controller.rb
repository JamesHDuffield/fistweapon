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
    client = Battlenet.WOWClient
    guild = client.guild({realm: config.realm, guild_name: config.guild_name})
    character = client.character({realm: config.realm, character_name: config.character_name})

    ApiRequest.cache(:discord, config.cache_discord) do
      logger.info "Updating Discord"
      discord
    end

    ApiRequest.cache(:guild_members, config.cache_members) do
      logger.info "Updating Guild"
      members(guild)
    end

    ApiRequest.cache(:guild_news, config.cache_events) do
      logger.info "Updating News"
      events(guild)
    end

    ApiRequest.cache(:guild_progression, config.cache_progression) do
      logger.info "Updating Progression"
      progression(character)
    end

    @members = Member.order('level DESC, rank ASC, name ASC').where('level >= ?', 100)
    @events = Event.order('event_timestamp DESC').take(200)
    @raids = config.raids
    @progression = Progression.where(:raid => @raids).group_by { |p| p.raid }
    @guild = Guild.find_by(name: config.guild_name)
    @discord = Discord.order('discord_timestamp DESC').take(3)
  end

  private
    def discord
      config = Rails.application.config
      messages = HTTParty.get("https://discordapp.com/api/channels/#{config.discord_channel_id}/messages", headers: {"Authorization" => config.discord_key })
      messages.each do |m|
        Discord.find_or_initialize_by(:message_id => m['id'], :channel_id => m['channel_id']).
        update_attributes!(:content => m['content'], :author => m['author']['username'], :discord_timestamp => m['timestamp'], :pinned => m['pinned'])
      end
    rescue Exception => e
      logger.error("Discord update error: #{e.message}")
    end

    def members(guild)
      body = guild.members
      e = body['emblem']
      Guild.find_or_initialize_by(:name => body['name'], :realm => body['realm']).
      update_attributes!(
        :level => body['level'],
        :side => body['side'],
        :achievement_points => body['achievementPoints'],
        :icon => e['icon'],
        :icon_colour => e['iconColor'],
        :icon_colour_id => e['iconColorId'],
        :border => e['border'],
        :border_colour => e['borderColor'],
        :border_colour_id => e['borderColorId'],
        :background_colour => e['backgroundColor'],
        :background_colour_id => e['backgroundColorId'],
      )
      body['members'].each do |m|
        c = m.fetch('character', {})
        s = c.fetch('spec', {})
        Member.find_or_initialize_by(:name => c['name']).
        update_attributes!(:character_class => c['class'], :race => c['race'], :gender => c['gender'], :level => c['level'], :rank => m['rank'], :spec => s['name'], :icon => s['icon'])
      end
    rescue Exception => e
      logger.error("Guild update error: #{e.message}")
    end

    def events(guild)
      body = guild.news
      max_timestamp = Event.maximum(:event_timestamp) || 0
      body['news'].each do |n|
        event_timestamp = Time.at(n['timestamp'] / 1000)
        if event_timestamp > max_timestamp
          a = n.fetch('achievement', {})
          case n['type']
            when "itemLoot"
              title = 'Looted Item'
            when "itemCrafted"
              title = 'Crafted Item'
            when "guildAchievement"
              title = 'Earned guild achievement'
            else
              title = 'Earned achievement'
          end
          character_class = Member.find_by(name: n['character']).try(:character_class) || 0
          Event.find_or_initialize_by(:event_timestamp => event_timestamp, :character => n['character']).
          update_attributes!(:event_type => n['type'], :title => title, :itemId => n.fetch('itemId', nil), :achievementId => a.fetch('id', nil), :character_class => character_class)
        end
      end
    rescue Exception => e
      logger.error("Event update error: #{e.message}")
    end

    def progression(character)
      body = character.progression
      prog = body.fetch('progression', {})
      prog.fetch('raids', []).each do |r|
        r.fetch('bosses', []).each do |b|
          Progression.find_or_initialize_by(:raid => r['name'], :boss_id => b['id']).
          update_attributes!(
            :boss => b['name'],
            :lfr_kills => b.fetch('lfrKills', 0),
            :lfr_timestamp => Time.at(b.fetch('lfrTimestamp', 0) / 1000),
            :normal_kills => b.fetch('normalKills', 0),
            :normal_timestamp => Time.at(b.fetch('normalTimestamp', 0) / 1000),
            :heroic_kills => b.fetch('heroicKills', 0),
            :heroic_timestamp => Time.at(b.fetch('heroicTimestamp', 0) / 1000),
            :mythic_kills => b.fetch('mythicKills', 0),
            :mythic_timestamp => Time.at(b.fetch('mythicTimestamp', 0) / 1000),
          )
        end
      end
    rescue Exception => e
      logger.error("Progression update error: #{e.message}")
    end
end
