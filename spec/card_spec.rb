require 'card'

RSpec.describe Card do
  before :all do
    @match = Match.new(2)
    shuffle = false
    @cards = Card.new(shuffle)
  end

  describe '#size' do
    it 'should return number of cards' do
      expect(@cards.size).to eq(52)
    end
  end

  describe '#pass_card' do
    it 'should return #x cards from top of the cards' do
      expected = %w(K A A A A)
      expect(@cards.pass_card(5)).to eq(expected)
    end
  end

  describe '.rank' do
    it 'should return the rank of the last card that player played' do
      played_cards = { 1 => %w(K 5 J), 2 => %w(A Q 5), 3 => ['10', 'Q', nil] }
      expected = { 1 => 11, 2 => 5, 3 => 0 }
      expect(Card.rank(played_cards)).to eq(expected)
    end
  end

  describe '.get_card_set' do
    it 'should return a card set from 2 - A' do
      expected = %w(2 3 4 5 6 7 8 9 10 J Q K A)
      expect(Card.gen_card_set).to eq(expected)
    end
  end

  describe '.show_last_played_cards' do
    specify do
      expect do
        Card.show_last_played_cards(@match, false)
      end.to output.to_stdout
    end

    specify do
      expect do
        Card.show_last_played_cards(@match, true)
      end.to output.to_stdout
    end
  end
end
