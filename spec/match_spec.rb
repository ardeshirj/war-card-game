require 'match'

RSpec.describe Match do
  before :each do
    @match = Match.new(2, false)
  end

  describe '#players_draw_cards' do
    it 'should update played_cards match attribute' do
      expected = { 1 => %w(A A), 2 => %w(8 8) }
      @match.players_draw_cards(2)
      expect(@match.played_cards).to eq(expected)
    end
  end

  describe '#update' do
    it 'should report when the game result is draw' do
      @match.players_draw_cards(1)
      @match.played_cards.each_key do |player|
        @match.played_cards[player] = []
      end
      expect(@match.update).to eq(
        "Draw! - following players: #{@match.players.map(&:id)}")
    end

    it 'should report the possible winner' do
      @match.players_draw_cards(1)
      expect(@match.update).to eq('Player 1 won')
    end

    it 'should remove possible lost player(s)' do
      lost_player = @match.players[0]
      lost_player.cards = []

      expected = @match.players.select do |player|
        player.id != lost_player.id
      end

      @match.players_draw_cards(1)
      @match.update
      expect(@match.players).to eq(expected)
    end
  end

  describe '#war?' do
    it 'should return true if two players played the same cards' do
      @match.played_cards = { 1 => %w(2 5 J), 2 => %w(K 8 J) }
      expect(@match.war?).to eq(true)
    end

    it 'should return false if two players did not play the same cards' do
      @match.played_cards = { 1 => %w(2 5 J), 2 => %w(K 8 Q) }
      expect(@match.war?).to eq(false)
    end
  end

  describe '#over?' do
    it 'should return true if the game is draw' do
      @match.players_draw_cards(1)
      @match.played_cards.each_key do |player|
        @match.played_cards[player] = []
      end
      expect(@match.over?).to eq(true)
    end

    it 'should return true if only one player left' do
      @match.players.delete_if { |player| player.id != 1 }
      expect(@match.over?).to eq(true)
    end
  end
end
