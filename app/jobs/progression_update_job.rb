class ProgressionUpdateJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    Delayed::Worker.logger.debug("Updating Progression") 
    config = Rails.application.config
    client = Battlenet.WOWClient
    guild = client.guild({realm: config.realm, guild_name: config.guild_name})
    character = client.character({realm: config.realm, character_name: config.character_name})
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
    Delayed::Worker.logger.error("Progression update error: #{e.message}")
  end
end
