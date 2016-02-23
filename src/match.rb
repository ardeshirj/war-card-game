require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players

  def initialize(player_count)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    # [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]
    @card_set = ('2'..'10').to_a + %w(J Q K A)
    @cards = @card_set.product(suits).map { |c, _s| c.to_s }
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

    cards_rank = find_cards_rank

    winner_player = update_winner_cards(cards_rank)
    delete_lost_players(cards_rank)

    return "Player #{winner_player.id} won" unless winner_player.nil?
  end

  def update_winner_cards(cards_rank)
    winner_card = cards_rank.max_by { |_player_id, card_rank| card_rank }
    winner = find_player(winner_card[0])
    winner.add_cards(@played_cards.values.flatten)

    @played_cards.clear

    winner
  end

  def delete_lost_players(cards_rank)
    # Remove the lost players (player with card_rank = 0)
    lost_player = nil
    cards_rank.each do |player_id, card_rank|
      if card_rank == 0
        lost_player = find_player(player_id)
        @players.delete(lost_player)
      end
    end
  end

  def draw?
    # If all players did NOT have a card to play then it is draw
    no_card_players = @played_cards.values.select { |cards| cards.last.nil? }
    return true if no_card_players.size == @players.size
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
    winner = @players.detect { |player| player.cards.size == @cards.size }
    unless winner.nil?
      puts "Player #{winner.id} won the game"
      return true
    end

    if @players.size == 1
      puts "Player #{@players.first.id} won the game"
      return true
    end

    return true if draw?
  end

  private

  def setup_players(player_counts)
    game_cards = cards.shuffle
    cards_count = game_cards.size

    (1..player_counts).map do |player_count|
      player_cards = game_cards.pop(cards_count / player_counts)
      Player.new(player_count, player_cards)
    end
  end

  def find_player(player_id)
    @players.find { |player| player.id == player_id }
  end

  def find_cards_rank
    cards_rank = {}
    @played_cards.each do |player_id, cards|
      rank = 0
      rank = @card_set.find_index(cards.last) + 2 unless cards.last.nil?
      cards_rank[player_id] = rank
    end
    cards_rank
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
  end
end
