class Member < ActiveRecord::Base
  def spec_url
    if self.icon != nil
      return "http://media.blizzard.com/wow/icons/56/#{self.icon}.jpg"
    else
      return "http://media.blizzard.com/wow/icons/56/Inv_misc_questionmark.jpg"
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
    "http://www.askmrrobot.com/wow/gear/us/barthilas/#{self.name}"
  end
end
