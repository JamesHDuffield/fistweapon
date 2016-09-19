class Query
  def initialize(fields)
     @hash = {:apikey => "ng6bgwrqguymnyh6uufcmds5f4nr3hde", :locale => "en_US", :fields => fields}
  end

  def get()
    return @hash
  end
end
