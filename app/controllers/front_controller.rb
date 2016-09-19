class FrontController < ApplicationController

  def index
    g = Guild.new("barthilas", "Fist Weapon")
    puts g.members
  end

end
