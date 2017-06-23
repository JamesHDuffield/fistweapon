module ApplicationHelper
  def guild_name
    Rails.application.config.guild_name
  end

  def darken_color(hex_color, amount=0.6)
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = (rgb[0].to_i * amount).round
    rgb[1] = (rgb[1].to_i * amount).round
    rgb[2] = (rgb[2].to_i * amount).round
    "#%02x%02x%02x" % rgb
  end

  def guild_colour
    g = Guild.find_by(name: Rails.application.config.guild_name)
    if g == nil
      return '#000'
    end
    return darken_color(g.background_colour.last(6))
  end

  def combat_logs_url
    return Rails.application.config.combat_logs_url
  end

  def render_log_link
    url = combat_logs_url
    if url != nil
      content_tag(:a, '', href: url)
    end
  end

  def cp(path)
    "active" if current_page?(path)
  end
end
