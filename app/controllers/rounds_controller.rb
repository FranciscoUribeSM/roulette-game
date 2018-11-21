class RoundsController < ApplicationController
  
  def index
    #Variables for handling classes of the navbar
    @round_class ="active"
    @player_class = ""

    @rounds = Round.paginate(:page => params[:page], :per_page => 15).all.order(created_at: :desc)

    #query of tables players and bets for main view
    @bets_of_plyers = Player.joins("INNER JOIN bets ON bets.player_id = players.id")
                            .select("bets.round_id,  
                                     players.id, 
                                     players.name, 
                                     bets.gain, 
                                     bets.amount, 
                                     bets.color, 
                                     bets.round_id")
                             .order(created_at: :desc)
  end

end