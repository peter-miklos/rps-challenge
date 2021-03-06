require 'game'

describe Game do

  subject(:game) {described_class.new(player1, player2)}
  let(:player1) { double :player1 }
  let(:player2) { double :player2 }

  before(:each) do
    allow(player1).to receive(:add_win) {player1}
    allow(player2).to receive(:add_win) {player2}
  end

  context '#self.create' do
    it "creates a new instance of the Game class" do
      Game.create(player1, player2)
      expect(Game.instance.class).to eq Game
    end
  end

  context '#self.instance' do
    it "returns the saved Game instance" do
      other_game = Game.create(player1, player2)
      expect(Game.instance).to eq other_game
    end
  end

  context '#player_1' do
    it 'returns player1' do
      expect(game.player_1).to eq player1
    end
  end

  context '#player2' do
    it 'returns player2' do
      expect(game.player_2).to eq player2
    end
  end

  context '#turn_won' do
    it "reduces the lives of the player by calling a player method" do
      expect(player1).to receive(:add_win)
      game.turn_won(player1)
    end
  end

  context '#play_game' do
    it 'returns player with rock, if the other player is with scissors' do
      expect(game.play_game(:rock, :lizard)).to eq player1
    end
    it "returns player with scissors, if the other player is with paper" do
      expect(game.play_game(:scissors, :spock)).to eq player2
    end
    it "returns player with paper if the other player is with rock" do
      expect(game.play_game(:spock, :rock)).to eq player1
    end
    it "returns 'draw' if players' choices are the same" do
      expect(game.play_game(:lizard, :lizard)).to eq "draw"
    end
  end

  context '#add_player1_choice' do
    it 'store the choice of player 1' do
      game.add_player1_choice(:rock)
      expect(game.player_1_choice).to eq :rock
    end
  end

end
