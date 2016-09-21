class Member < ActiveRecord::Base
  def spec_url
    if self.icon != nil
      return "http://media.blizzard.com/wow/icons/56/#{self.icon}.jpg"
    else
      return "http://media.blizzard.com/wow/icons/56/Inv_misc_questionmark.jpg"
    end
  end
end
