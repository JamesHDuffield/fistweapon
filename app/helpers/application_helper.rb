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
end
