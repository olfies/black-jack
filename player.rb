class Player
  attr_accessor :name, :money, :cards

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end

  def print_info(player, attr)
    puts "#{player.name} #{attr.to_s.capitalize}: #{player.send(attr)}"
  end

  def make_bet
    @money -= 10
  end

  def limit_cards?
    cards.size == 3
  end

  def points
    points = 0
    cards.each do |card|
      points += if card.ace? && points <= 10
                  card.get_points.last
                elsif card.ace?
                  card.get_points.first
                else
                  card.get_points
                end
    end
    points
  end
end
