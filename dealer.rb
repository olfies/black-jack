class Dealer < Player
  def initialize(name="Dealer")
    super
  end

  def take_card?
    self.points <= 18
  end
end
