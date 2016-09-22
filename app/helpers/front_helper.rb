module FrontHelper
  def render_type(e)
    if e.event_type == "itemLoot" or e.event_type == "itemCraft"
      content_tag(:a, '', href: "http://www.wowhead.com/item=#{e.itemId}")
    elsif e.event_type == "playerAchievement" or e.event_type="guildAchievement"
      content_tag(:a, '', href: "http://wotlk.wowhead.com/achievement=#{e.achievementId}")
    else
      e.event_type
    end
  end
end
