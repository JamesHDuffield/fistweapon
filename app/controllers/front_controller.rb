class FrontController < ApplicationController

  def index
    #members
    url = Guild.new("barthilas", "Fist Weapon").members
    ApiRequest.cache(url, lambda { 1.days.ago }) do
      res = HTTParty.get(url)
      body = JSON.parse(res.body)
      puts "Updating Members"
      body['members'].each do |m|
        c = m.fetch('character', {})
        s = c.fetch('spec', {})
        Member.find_or_initialize_by(:name => c['name']).
        update_attributes!(:character_class => c['class'], :race => c['race'], :gender => c['gender'], :level => c['level'], :rank => m['rank'], :spec => s['name'], :icon => s['icon'])
      end
    end
    @members = Member.all

    #news
    
  end
end
