class Member < ActiveRecord::Base
  def member_name=(name)
    user = Member.find_by_name(name)
    if user
      self.member_id = member.id
    else
      errors[:member_name] << "Invalid name entered"
    end
  end

  def member_name
    Member.find(member_id).name if member_id
  end

  def spec_url
    config = Rails.application.config
    if self.icon != nil
      return "#{config.media_url_base}/#{self.icon}.jpg"
    else
      return "/Inv_misc_questionmark.jpg"
    end
  end

  def rank_name
    case self.rank
    when 0
      'Guild Leader'
    when 1
      'Officer'
    when 6
      'Awareness Master'
    else
      'Member'
    end
  end

  def ask_mr_robot
    config = Rails.application.config
    "#{config.amr_url_base}/#{config.realm}/#{self.name}"
  end
end
