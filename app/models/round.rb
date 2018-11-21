class Round < ApplicationRecord
    has_many :bets


    
    # choose color of bet and round randomly
    def self.roulette_color
        number_rand = rand(100)+1

        if number_rand < 3 
            return "verde"
        elsif number_rand >= 3 && number_rand <=51
            return "rojo"
        else 
            return "negro"
        end

    end 

    # calculates the player's bet
    def self.bet_player temp,money_user

        if money_user > 0 && money_user<= 1000
            return money_user
        else
            if temp < 27
                return rand(8..15)*money_user/100
            else 
                return rand(3..7)*money_user/100
            end
        end

    end

    # check if the player won the round, and how much
    def self.check_bet color_player, color_round, amount

        if color_player != color_round
            return 0
        else
            if color_player == "rojo" || color_player == "negro"
                return amount*2
            else 
                return amount*15
            end 
        end 
        
    end

    # create a new round, it is the main function 
    def self.new_round
        players = Player.where("money > ?", 0)
        
        #check if there are players to make a round
        if players.length != 0

            round = Round.create(color:roulette_color()  ,temp:Weather.forecast_weather)
            round.save

            players.each do |player|
                user_color = roulette_color()
                amount_bet = bet_player(round.temp,player.money)
                gain_user  = check_bet(user_color,round.color,amount_bet)

                #check if the player has money to play
                if amount_bet != 0 
                    bet = Bet.create(
                            amount:amount_bet, 
                            color: user_color , 
                            gain:gain_user,
                            round_id:round.id, 
                            player_id:player.id,
                            player_balance:player.money
                        )
                    bet.save

                    # check if the player won
                    if !gain_user 
                        player.money = (player.money - amount_bet)
                    else
                        player.money += (check_bet(round.color, bet.color, bet.amount) - amount_bet)
                    end
                    player.save

                end
            end
        end
    end

end