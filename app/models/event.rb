class Event < ApplicationRecord
  def character_class
    me = Member.find_by name: self.character
    return me.character_class
  end

  def ask_mr_robot
    me = Member.find_by name: self.character
    return me.ask_mr_robot
  end

end
