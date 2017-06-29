if Rake.application.top_level_tasks.include?("jobs:work")
    Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
    Delayed::Job.destroy_all
    EventUpdateJob.set(cron: '*/5 * * * *').perform_later
    MemberUpdateJob.set(cron: '0 */2 * * *').perform_later
    DiscordUpdateJob.set(cron: '*/5 * * * *').perform_later
    ProgressionUpdateJob.set(cron: '0 */2 * * *').perform_later
end