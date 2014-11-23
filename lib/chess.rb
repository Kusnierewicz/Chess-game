require_relative "chess/version"
require_relative "chess/player.rb"
require_relative "chess/board.rb"
require_relative "chess/game.rb"
require_relative "chess/load_save.rb"
require_relative "chess/pieces.rb"

module Chess
  def start_game
  	puts "Welcome to chess game"
  	bob = Chess::Player.new({color: "X", name: "bob"})
  	frank = Chess::Player.new({color: "O", name: "frank"})
  	players = [bob, frank]
  	Chess::Game.new(players).play
  end
end

s = Chess.new.star_game