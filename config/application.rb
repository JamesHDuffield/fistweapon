require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fistweapon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    Battlenet.configure do |config|
      config.api_key = ENV['BNET_API_KEY']
      config.region = ENV['BNET_REGION'].to_sym
    end

    Rails.application.configure do
      config.after_initialize do
        config.realm = ENV['WOW_REALM']
        config.guild_name = ENV['WOW_GUILD']
        config.character_name = ENV['WOW_CHARACTER_NAME'] #Used for progression lookup (use guild leader generally)
        config.raids = ENV['WOW_RAIDS'].split(",")
        config.amr_url_base = 'http://www.askmrrobot.com/wow/gear/us'
        config.media_url_base = 'http://media.blizzard.com/wow/icons/56'
        config.cache_members = lambda { 1.days.ago }
        config.cache_events = lambda { 5.minutes.ago }
        config.cache_discord = lambda { 1.minutes.ago }
        config.cache_progression = lambda { 1.days.ago }

        config.discord_channel_id = ENV['DISCORD_CHANNEL_ID']
        config.discord_key = ENV['DISCORD_KEY']
      end
    end

  end
end
