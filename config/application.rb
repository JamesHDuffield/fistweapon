require_relative 'boot'

require 'rails/all'

def get_env(key)
  if ENV[key] == nil
    throw "Enviroment key #{key} not set"
  end
  return ENV[key]
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fistweapon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    Battlenet.configure do |config|
      config.api_key = get_env('BNET_API_KEY')
      config.region = get_env('BNET_REGION').to_sym
    end

    Rails.application.configure do
      config.after_initialize do
        config.realm = get_env('WOW_REALM')
        config.guild_name = get_env('WOW_GUILD')
        config.character_name = get_env('WOW_CHARACTER_NAME') #Used for progression lookup (use guild leader generally)
        config.raids = get_env('WOW_RAIDS').split(",")
        config.amr_url_base = 'http://www.askmrrobot.com/wow/gear/us'
        config.media_url_base = 'http://media.blizzard.com/wow/icons/56'
        config.cache_members = lambda { 1.days.ago }
        config.cache_events = lambda { 5.minutes.ago }
        config.cache_discord = lambda { 1.minutes.ago }
        config.cache_progression = lambda { 1.days.ago }

        config.discord_channel_id = get_env('DISCORD_CHANNEL_ID')
        config.discord_key = get_env('DISCORD_KEY')
      end
    end

  end
end
