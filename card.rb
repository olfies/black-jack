class Card
  attr_reader :rank, :suit, :points
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @points =[]
  end

  def get_points
    ranks = %i[k q j]
    if ranks.include?(rank)
      10
    elsif rank == :a
      [1, 11]
    else
      rank.to_i
    end
  end

  def count_points
    count = []
    points.each do |point|
      count << if count.sum + point > 21 && (count.include?(11) || point == 11)
                 point - 10
               else
                 point
               end
    end
    count.sum
  end

  def ace?
    rank == :a
  end

  def to_s
    symbols = { diamonds: "\u2666", hearts: "\u2665", clubs: "\u2663", spades: "\u2660" }.freeze
    "#{rank.to_s.capitalize}#{symbols[suit]}"
  end
end
