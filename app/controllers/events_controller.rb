class EventsController < ApplicationController

  def index
    config = Rails.application.config
    @events = Event.order('event_timestamp DESC').take(config.event_max_items)
  end

end
