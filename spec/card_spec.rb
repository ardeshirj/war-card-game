require 'spec_helper'

RSpec.describe Card do
  before :all do
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

  describe '.show_played_cards' do
    player = Player.new(1, %w(A 10 6))
    played_cards = %w(4 5 10)

    draw_war_cards = 1
    specify do
      expect do
        Card.show_played_cards(player, played_cards, draw_war_cards)
      end.to output.to_stdout
    end

    draw_war_cards = 2
    specify do
      expect do
        Card.show_played_cards(player, played_cards, draw_war_cards)
      end.to output.to_stdout
    end
  end
end
