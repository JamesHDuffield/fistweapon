class FrontController < ApplicationController

  def index
    url = Guild.new("barthilas", "Fist Weapon").members
    @members = ApiRequest.cache(url, lambda { 1.days.ago })
  end



end
