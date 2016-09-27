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
      config.api_key = 'ng6bgwrqguymnyh6uufcmds5f4nr3hde'
      config.region  = :us
    end

    Rails.application.configure do
      config.after_initialize do
        config.realm = 'barthilas'
        config.guild_name = 'Fist Weapon'
        config.character_name = 'Spidr' #Used for progression lookup (use guild leader generally)
        config.raids = ['The Emerald Nightmare', 'Hellfire Citadel']
        config.amr_url_base = 'http://www.askmrrobot.com/wow/gear/us'
        config.media_url_base = 'http://media.blizzard.com/wow/icons/56'
        config.cache_members = lambda { 1.days.ago }
        config.cache_events = lambda { 5.minutes.ago }
        config.cache_discord = lambda { 1.minutes.ago }
        config.cache_progression = lambda { 1.days.ago }

        config.discord_channel_id = 226638929049288704
        config.discord_key = 'Bot MjI4NzY2OTYzMDM4NTUyMDY0.CsZoGQ.KolNZnvu4HlxN781lRuAy1a4qDI'
      end
    end

  end
end
