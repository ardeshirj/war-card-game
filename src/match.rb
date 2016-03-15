require_relative './player.rb'
require_relative './card.rb'

# Hold information about the players and cards
class Match
  attr_reader :cards
  attr_accessor :played_cards
  attr_accessor :players

  def initialize(player_count, shuffle = true)
    @cards = Card.new(shuffle)
    @players = setup_players(player_count)
    @played_cards = Hash.new { |hash, key| hash[key] = [] }
  end

  def players_draw_cards(card_count)
    @players.each do |player|
      played_cards = player.draw_cards(card_count)
      played_cards.each do |cards|
        @played_cards[player.id] << cards
      end
    end
  end

  def update
    if draw?
      draw_players = @players.map(&:id)
      return "Draw! - following players: #{draw_players}"
    end

    cards_rank = Card.rank(@played_cards)
    winner_player = update_winner_cards(cards_rank)
    Player.delete_lost_players(@players, cards_rank)

    return "Player #{winner_player.id} won" unless winner_player.nil?
  end

  def war?
    last_played_cards = []
    @played_cards.values.each { |cards| last_played_cards << cards.last }

    equal_cards = last_played_cards.detect do |card|
      last_played_cards.count(card) > 1
    end

    equal_cards.nil? ? false : true
  end

  def over?
    return true if @players.size == 1 || draw?
  end

  private

  def setup_players(player_counts)
    player_card_count = @cards.size / player_counts

    (1..player_counts).map do |player_count|
      player_cards = @cards.pass_card(player_card_count)
      Player.new(player_count, player_cards)
    end
  end

  def update_winner_cards(cards_rank)
    winner_card = cards_rank.max_by { |_player_id, card_rank| card_rank }
    winner = Player.find_player(@players, winner_card[0])
    winner.add_cards(@played_cards.values.flatten.compact)

    @played_cards.clear

    winner
  end

  def draw?
    # If all players did NOT have a card to play then it is draw
    no_card_players = @played_cards.values.select { |cards| cards.last.nil? }
    return true if no_card_players.size == @players.size
  end

  def show_the_winner
    puts 'The game is still in progress..' unless @match.over?
    puts @players.last
  end
end
