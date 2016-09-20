class Query
  def initialize(fields)
     @hash = {:apikey => ENV['apikey'], :locale => "en_US", :fields => fields}
  end

  def get
    return @hash
  end
end
