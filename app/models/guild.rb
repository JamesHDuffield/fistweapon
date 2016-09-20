class Guild
  BASE_URL = 'https://us.api.battle.net/wow/guild/'
  CACHE_POLICY = lambda { 30.days.ago }

  def initialize(realm, guildName)
    @realm = URI.encode(realm)
    @guildName = URI.encode(guildName)
  end

  def members
    url = BASE_URL + "/" + @realm + "/" + @guildName + "?" + {
      apikey: "ng6bgwrqguymnyh6uufcmds5f4nr3hde",
      locale: "en_US",
      fields: "members"
    }.to_query
  end

end
