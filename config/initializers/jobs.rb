if Rake.application.top_level_tasks.include?("jobs:work")
    Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
    Delayed::Job.destroy_all
    EventUpdateJob.perform_later
    MemberUpdateJob.perform_later
    DiscordUpdateJob.perform_later
    ProgressionUpdateJob.perform_later
end