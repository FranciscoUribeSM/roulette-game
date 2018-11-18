class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player_bets = Bet.where(player_id: @player.id).order(created_at: :asc)
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.money = 10000

      if @player.save
          redirect_to @player, notice: 'Player was successfully created.'
      else
          render :new 
      end
    
  end

  def bonus 
    Player.bonus
    redirect_to players_path
  end 
  
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    
      if @player.update(player_params)
        redirect_to @player, notice: 'Player was successfully updated.'
      else
        render :edit 
      end

  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :money)
    end
end
