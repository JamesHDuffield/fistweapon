module EventsHelper
  def render_type(e)
    if e.event_type == "itemLoot" or e.event_type == "itemCraft"
      content_tag(:a, '', href: "http://www.wowhead.com/item=#{e.itemId}")
    elsif e.event_type == "playerAchievement" or e.event_type="guildAchievement"
      content_tag(:a, '', href: "http://wotlk.wowhead.com/achievement=#{e.achievementId}")
    else
      e.event_type
    end
  end

  def display_time(time)
    if time <= Time.now
      "#{time_ago_in_words(time)} ago"
    else
      "#{time_ago_in_words(time)} from now"
    end
  end
end
