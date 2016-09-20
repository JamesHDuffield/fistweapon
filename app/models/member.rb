class Member < ActiveRecord::Base
  def spec_url
    "http://media.blizzard.com/wow/icons/56/#{self.icon}.jpg"
  end
end
