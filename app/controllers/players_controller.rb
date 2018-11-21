class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    #Variables for handling classes of the navbar
    @round_class =""
    @player_class = "active"
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player_bets = Bet.where(player_id: @player.id).paginate(:page => params[:page], :per_page => 20).order(created_at: :desc)
  end

  # GET /players/new
  def new
    @player = Player.new
    @name_button = "Agregar"
  end

  # GET /players/1/edit
  def edit
    
    @name_button = "Editar"
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.money = 10000

      if @player.save
          redirect_to @player, notice: 'Jugador creado exitosamente.'
      else
          render :new 
      end
    
  end

  
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    
      if @player.update(player_params)
        redirect_to @player, notice: 'Jugador fue modificado exitosamete.'
      else
        render :edit 
      end

  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy

     redirect_to players_url, notice: 'Jugador fue eliminado.' 


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
