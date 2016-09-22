class Event < ApplicationRecord

  def ask_mr_robot
    config = Rails.application.config
    "#{config.amr_url_base}/#{config.realm}/#{self.character}"
  end

end
