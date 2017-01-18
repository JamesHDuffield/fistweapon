class EventUpdateJob < ApplicationJob
  queue_as :default
  
  after_perform do |job|
    EventUpdateJob.set(wait: 5.minute).perform_later
  end

  def perform(*args)
    logger.info "Updating Events"
    config = Rails.application.config
    client = Battlenet.WOWClient
    guild = client.guild({realm: config.realm, guild_name: config.guild_name})
    body = guild.news
      max_timestamp = Event.maximum(:event_timestamp) || 0
      body['news'].each do |n|
        event_timestamp = Time.at(n['timestamp'] / 1000 - 3600) # Minus 1 hour for blizz giving us off epoch timestamps
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
      Event.order('event_timestamp desc').offset(1000).destroy_all # Ensure we do not keep too much history (Heroku will compain if too much db space used)
    rescue Exception => e
      logger.error("Event update error: #{e.message}")
  end
end


