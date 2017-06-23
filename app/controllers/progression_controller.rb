class ProgressionController < ApplicationController

  def index
    config = Rails.application.config
    @raids = config.raids
    @progression = Progression.where(:raid => @raids).group_by { |p| p.raid }
  end

end
