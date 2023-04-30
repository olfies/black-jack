module Round

  def user_select
    puts "Выберите действие: (1) взять карту, (2) пропустить ход, (3) открыть карты"
    choice = gets.chomp.downcase.to_i
    case choice
    when 1
      take_card(user)
    when 2
      skip_turn(user)
    when 3
      open_cards
    else
      puts 'Никаких действий не предусмотрено!'
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

  def check_winner
    if (user.points > dealer.points) && user.points <= 21
      user
    elsif user.points == dealer.points
      "Ничья!"
    else
      dealer
    end
  end


  def show_cards(player, visible = true)
    puts "Карту у  #{player.name.to_s.capitalize}:"
    puts '*' * player.cards.size if visible == false
    puts player.cards if visible == true
  end

  def start_new_round
    puts 'Хочешь сыграть еще раз? (Y, N)'
    choice = gets.chomp.downcase
    if choice == 'y'
      round_play
    else
      exit_method
    end
  end


  def print_round_end(winner)
    if winner == "Ничья!"
      print_separator
      puts winner
    else
      print_separator
      [user, dealer].each {|p| print_info(p, :points)}
      puts "--> #{winner.name.to_s.capitalize} Победа!"
      print_separator
    end
    [user, dealer].each {|p| print_info(p, :money)}
    print_separator
  end

  def print_separator
    puts "-" * 19
  end

  private

  def exit_method
    puts "Игра окончена!"
    exit
  end
end
