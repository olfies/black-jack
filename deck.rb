class Deck
  attr_reader :cards

  def initialize
    @cards = []
    suits = %i[diamonds hearts spades clubs]
    ranks = [:a, :k, :q, :j, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    ranks.each do |c|
      suits.each do |s|
        @cards << Card.new(c, s)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def pull_out
    @cards.shift
  end
end
