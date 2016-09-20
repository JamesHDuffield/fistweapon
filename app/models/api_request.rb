class ApiRequest < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy)
    find_or_initialize_by(url: url).cache(cache_policy) do
      if block_given?
        yield
      end
    end
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call
      update_attributes(updated_at: Time.zone.now)
      yield
    end
  end
end
