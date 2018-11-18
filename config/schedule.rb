
set :environment, :development               
set :output, "#{path}/log/cron_log.logs"    
env :GEM_PATH, ENV['GEM_PATH']              

# Create new round each 3 minutes
every 2.minutes do

    runner "Round.new_round"         

end

# add a $ 10,000 bonus to all player each day
every 1.day, at: => '00:00 am' do

    runner "Player.bonus"        

end

# Learn more: http://github.com/javan/whenever
