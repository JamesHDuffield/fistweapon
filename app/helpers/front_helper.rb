module FrontHelper
  def realm
    Rails.application.config.realm
  end

  def allegiance
    g = Guild.find_by(name: Rails.application.config.guild_name)
    if g != nil && g.side == 1
      content_tag(:div, 'Horde Guild', class: "guild-side horde")
    else
      content_tag(:div, 'Aliiance Guild', class: "guild-side alliance")
    end
  end
end
