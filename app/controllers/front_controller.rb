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

    #news
    url = Guild.new("barthilas", "Fist Weapon").news
    ApiRequest.cache(url, lambda { 1.days.ago }) do
      res = HTTParty.get(url)
      body = JSON.parse(res.body)
      puts "Updating News"
      body['news'].each do |n|
        a = n.fetch('achievement', {})
        if a == {}
          title = 'Looted Item'
          description = ''
        else
          title = a['title']
          description = a['description']
        end
        Event.find_or_initialize_by(:when => n['timestamp']).
        update_attributes!(:character => n['character'], :event_type => n['type'], :title => title, :itemId => n.fetch('itemId', nil), :achievementId => a.fetch('id', nil))
      end
    end

    @members = Member.order('rank ASC, name ASC').all
    @events = Event.all
  end
end
