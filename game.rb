require_relative 'player'
require_relative 'card'
require_relative 'round'
require_relative 'deck'

class Game
  include Round

  attr_accessor :user, :dealer, :deck, :bank

  def initialize(user, dealer = Dealer.new)
    @user = user
    @dealer = dealer
    @bank = 0
  end


  def new_round
    @deck = Deck.new
    @deck.shuffle!
    [user, dealer].each do |player|
      player.cards = []
      player.make_bet
      2.times { take_card(player) }
    end
    @bank = 20
  end

  def print_info(player, attr)
    puts "#{player.name.to_s.capitalize}'s #{attr.to_s.capitalize}: #{player.send(attr)}"
  end

  def round_play
    new_round
    until round_end?
      gambler_turn
      dealer_turn
    end
    open_cards
  end

  def gambler_turn
    show_cards(dealer, false)
    show_cards(user)
    user_select
  end

  def dealer_turn
    if dealer.take_card?
      take_card(dealer)
    else
      skip_turn(dealer)
    end
  end

  def take_card(player)
    player.cards << deck.pull_out
  end

  def skip_turn(player)
    puts "#{player.name} пропуск хода!"
  end

  def open_cards
    [self.user, self.dealer].each {|p| show_cards(p, true)}
    winner = check_winner
    take_bank(winner)
    print_round_end(winner)
    start_new_round
  end


  def round_end?
    if user.limit_cards? && dealer.limit_cards?
      true
    elsif user.limit_cards? && !dealer.take_card?
      true
    else
      false
    end
  end


  def take_bank(winner)
    if winner == "Ничья!"
      user.money += @bank / 2
      dealer.money += @bank / 2
    else
      winner.money += @bank
    end
  end

end
