# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# done every weekday from 8am to 6pm every 15 minutes
every :weekday, :at => ('08'..'18').to_a.collect {|x| ["#{x}:00","#{x}:15","#{x}:30","#{x}:45"]}.flatten do
  rake "locker:watch"
end

every :weekday, :at => '1am' do
  rake 'locker:process'
end
