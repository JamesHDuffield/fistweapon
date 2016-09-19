class Guild
  include HTTParty
  base_uri 'https://us.api.battle.net/wow/guild/'

  def initialize(realm, guildName)
    @realm = URI.encode(realm)
    @guildName = URI.encode(guildName)
  end

  def news
    self.class.get("/" + @realm + "/" + @guildName, { query: Query.new('news').get() })
  end

  def members
    self.class.get("/" + @realm + "/" + @guildName, { query: Query.new('members').get() })
  end

  def realmStatus
    self.class.get("/realm/status", @options)
  end
end
