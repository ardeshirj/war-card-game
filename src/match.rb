require_relative './player.rb'
require_relative './card.rb'

# Hold information about the players and cards
class Match
  attr_reader :players
  attr_reader :played_cards
  attr_reader :card_set
  attr_reader :cards

  def initialize(player_count)
    @match_cards = Card.new
    @players = setup_players(player_count)
    @played_cards = Hash.new { |hash, key| hash[key] = [] }
  end

  def players_draw_cards(card_count)
    draw_war_cards = true if card_count == 2

    @players.each do |player|
      played_cards = player.draw_cards(card_count)

      show_status(player, played_cards, draw_war_cards)

      played_cards.each do |played_card|
        @played_cards[player.id] << played_card
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
    if @players.size == 1
      puts "Player #{@players.first.id} won the game"
      return true
    end

    return true if draw?
  end

  private

  def setup_players(player_counts)
    player_card_count = @match_cards.size / player_counts

    (1..player_counts).map do |player_count|
      player_cards = @match_cards.pass_card(player_card_count)
      Player.new(player_count, player_cards)
    end
  end

  def show_status(player, played_cards, draw_war_cards)
    print "Player[#{player.id}] (##{player.cards.size} cards):"
    if draw_war_cards
      war_cards = []
      played_cards.each_index do |index|
        index.even? ? war_cards << 'X' : war_cards << played_cards[index]
      end
      puts "#{war_cards}"
    else
      puts "#{played_cards}"
    end
    # p player.cards
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
end
