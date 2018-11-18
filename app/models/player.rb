class Player < ApplicationRecord

    has_many :bets
    # add bonus daily of $10000 to each player 
    def self.bonus
            all.each do |player|
                player.money += 10000
                player.save
            end
    end

end
