module ApplicationHelper
  def guild_name
    Rails.application.config.guild_name
  end

  def guild_colour
    g = Guild.find_by(name: Rails.application.config.guild_name)
    if g == nil
      return '#000'
    end
    return "##{g.background_colour.last(6)}"
  end
end
