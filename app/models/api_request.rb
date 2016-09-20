class ApiRequest < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy)
    r = find_or_initialize_by(url: url)
    r.cache(cache_policy) do
      res = HTTParty.get(url)
      r.update_attributes(response: res.body)
    end
    res = find_or_initialize_by(url: url)[:response]
    return JSON.parse(res)
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call
      update_attributes(updated_at: Time.zone.now)
      yield
    end
  end

end
