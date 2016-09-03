require 'sinatra/base'
require_relative './lib/player'
require_relative './lib/game'
require_relative './lib/computer'

class RPS < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/names' do
    @name = params[:player]
    player = Player.new(@name)
    computer = Computer.new
    Game.create(player, computer)
    redirect '/play'
  end

  get '/play' do
    @game = Game.instance
    erb :play
  end

  get '/form_shape?*' do
    @player_choice = params[:choice]
    @computer_choice = Game.instance.player_2.choice
    @winner = Game.instance.play_game(@player_choice, @computer_choice)
    erb :form_shape
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
