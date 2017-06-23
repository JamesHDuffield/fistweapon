class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :ensure_guild

  private
  def ensure_guild
    config = Rails.application.config
    @guild = Guild.find_by(name: config.guild_name)
  end
end
