class RoundsController < ApplicationController
  
  def index
    @rounds = Round.all

    #query of tables players and bets for main view
    @bets_of_plyers = Player.joins("INNER JOIN bets ON bets.player_id = players.id")
                            .select("bets.round_id,  
                                     players.id, 
                                     players.name, 
                                     bets.gain, 
                                     bets.amount, 
                                     bets.color, 
                                     bets.round_id")
  end

  # method to test
  def new_round 
    Round.new_round
    redirect_to root_path
  end

end