class FrontController < ApplicationController

  def index
    client = Battlenet.WOWClient
    guild = client.guild({realm: 'barthilas', guild_name: 'Fist Weapon'})
    character = client.character({realm: 'barthilas', character_name: 'Spidr'})

    #members
    ApiRequest.cache('guild_members', lambda { 1.days.ago }) do
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
    ApiRequest.cache('guild_news', lambda { 5.minutes.ago }) do
      body = guild.news
      logger.info "Updating News"
      body['news'].each do |n|
        event_timestamp = Time.at(n['timestamp'] / 1000)
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
        Event.find_or_initialize_by(:event_timestamp => event_timestamp, :character => n['character']).
        update_attributes!(:event_type => n['type'], :title => title, :itemId => n.fetch('itemId', nil), :achievementId => a.fetch('id', nil))
      end
    end

    #progression
    ApiRequest.cache('guild_progression', lambda { 1.days.ago }) do
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

    @members = Member.order('level DESC, rank ASC, name ASC').where('level >= 100')
    @events = Event.take(200)
    @progression = Progression.where("raid = 'The Emerald Nightmare' OR raid ='Hellfire Citadel'")
  end
end
