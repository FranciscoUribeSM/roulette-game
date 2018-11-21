


# Add a $ 10,000 bonus to all player each day
task :bonus => :environment do 
    Player.bonus
end 
# Create new round each 3 minutes
task :new_round => :environment do
    Round.new_round
end