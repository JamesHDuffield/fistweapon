class DiscordUpdateJob < ApplicationJob
  queue_as :default
  
  after_perform do |job|
    DiscordUpdateJob.set(wait: 12.hours).perform_later
  end

  def perform(*args)
    logger.info "Updating Discord"
    config = Rails.application.config
    if config.discord_channel_id == nil or config.discord_key == nil
      throw 'Skipping discord update due to missing channel or key'
      return
    end
    messages = HTTParty.get("https://discordapp.com/api/channels/#{config.discord_channel_id}/messages", headers: {"Authorization" => config.discord_key })
    messages.each do |m|
      Discord.find_or_initialize_by(:message_id => m['id'], :channel_id => m['channel_id']).
      update_attributes!(:content => m['content'], :author => m['author']['username'], :discord_timestamp => m['timestamp'], :pinned => m['pinned'])
    end
  rescue Exception => e
    logger.error("Discord update error: #{e.message}")
  end
end
