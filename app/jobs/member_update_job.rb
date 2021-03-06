class MemberUpdateJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
    Delayed::Worker.logger.debug("Updating Guild")
    config = Rails.application.config
    client = Battlenet.WOWClient
    guild = client.guild({realm: config.realm, guild_name: config.guild_name})
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
      :background_colour_id => e['backgroundColorId']
    )
    body['members'].each do |m|
      c = m.fetch('character', {})
      s = c.fetch('spec', {})
      begin
        char = client.character({realm: config.realm, character_name: c['name']})
        profile = char.profile
        last_mod = Time.at(profile['lastModified'] / 1000 - 3600)
        Member.find_or_initialize_by(:name => c['name']).
        update_attributes!(
          :character_class => c['class'],
          :race => c['race'],
          :gender => c['gender'], 
          :level => c['level'],
          :rank => m['rank'],
          :spec => s['name'],
          :icon => s['icon'],
          :last_modified => last_mod
        )
      rescue Exception => e
        Delayed::Worker.logger.error("Member fetch failed: #{e.message}")
      end
    end
  rescue Exception => e
    Delayed::Worker.logger.error("Guild update error: #{e.message}")
  end
end
