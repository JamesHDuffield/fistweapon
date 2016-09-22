class FrontController < ApplicationController

  def index
    config = Rails.application.config
    client = Battlenet.WOWClient
    guild = client.guild({realm: config.realm, guild_name: config.guild_name})
    character = client.character({realm: config.realm, character_name: config.character_name})

    #members
    ApiRequest.cache(:guild_members, config.cache_members) do
      body = guild.members
      logger.info "Updating Members"
      body['members'].each do |m|
        c = m.fetch('character', {})
        s = c.fetch('spec', {})
        Member.find_or_initialize_by(:name => c['name']).
        update_attributes!(:character_class => c['class'], :race => c['race'], :gender => c['gender'], :level => c['level'], :rank => m['rank'], :spec => s['name'], :icon => s['icon'])
      end
    end

    #news
    ApiRequest.cache(:guild_news, config.cache_events) do
      body = guild.news
      max_timestamp = Event.maximum(:event_timestamp) || 0
      logger.info "Updating News"
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
    end

    #progression
    ApiRequest.cache(:guild_progression, config.cache_progression) do
      body = character.progression
      prog = body.fetch('progression', {})
      logger.info "Updating Progression"
      prog.fetch('raids', []).each do |r|
        r.fetch('bosses', []).each do |b|
          logger.info b
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
    end

    @members = Member.order('level DESC, rank ASC, name ASC').where('level >= ?', 100)
    @events = Event.order('event_timestamp DESC').take(200)
    @raids = config.raids
    @progression = Progression.where(:raid => @raids).group_by { |p| p.raid }
  end
end
