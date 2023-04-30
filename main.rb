require_relative 'game'
require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'gambler'

puts 'Добро пожаловать в самую честную игру "Black Jack", чтобы начать оставлять свои деньги в нашей игре введите свое имя: '
username = gets.chomp

gambler = Gambler.new(username)
dealer = Dealer.new
game = Game.new(gambler, dealer)

game.round_play
