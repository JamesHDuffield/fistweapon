module MembersHelper
  def render_label(member)
    c = member.reports_count
    if c > 0 && member.reports_new
      link_to content_tag(:span, c, class: "label label-info"), member
    else
      link_to content_tag(:span, c, class: "label label-default"), member
    end
  end
end
