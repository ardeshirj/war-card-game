require 'player'

RSpec.describe Player do
  before :all do
    @players = [Player.new(1, %w(A 8 J 5 Q)),
                Player.new(2, [])]
  end

  before :each do
    @player = Player.new(1, %w(A 8 J 5 Q))
  end

  describe '#add_cards' do
    it 'should add cards to the bottom of player cards' do
      expected = %w(10 2 5 A 8 J 5 Q)
      new_cards = %w(10 2 5)
      expect(@player.add_cards(new_cards)).to eq(expected)
    end
  end

  describe '#draw_cards' do
    it 'should return #x of card(s) from top of the player cards' do
      expected = %w(Q 5 J)
      expect(@player.draw_cards(3)).to eq(expected)
    end

    it 'should return nil if there are not enough cards to draw' do
      expected = ['Q', '5', 'J', '8', 'A', nil]
      expect(@player.draw_cards(6)).to eq(expected)
    end
  end

  describe '.find_player' do
    it 'should find the player that matches the given id' do
      expected = @players[0]
      expect(Player.find_player(@players, 1)).to eql(expected)
    end
  end

  describe '.delete_lost_players' do
    it 'should delete player with card rank zero' do
      played_cards = {}
      @players.each do |player|
        played_cards[player.id] = player.draw_cards(1)
      end

      card_rank = Card.rank(played_cards)
      expected = [Player.find_player(@players, 1)]
      Player.delete_lost_players(@players, card_rank)

      expect(@players).to eq(expected)
    end
  end
end
