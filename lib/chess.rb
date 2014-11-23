require_relative "chess/version"
require_relative "chess/player.rb"
#require_relative "chess/board.rb"
#require_relative "chess/game.rb"
#require_relative "chess/load_save.rb"
require_relative "chess/pieces.rb"

module Chess

  
  class Test
  	def initialize
    #@player = Player.new
    #@password = Password.new
    #@round = 1
    end
    def start_test
  	  puts "Welcome to chess game"
  	  k = Chess::Knight.new(color: "black")
  	  #k = Chess::Knight.new
  	  puts k.class
  	  puts k.type
  	  puts k.color
  	  puts k.possible_moves
    end
  end

  def start_game
  	puts "Welcome to chess game"
  	bob = Chess::Player.new({color: "X", name: "bob"})
  	frank = Chess::Player.new({color: "O", name: "frank"})
  	players = [bob, frank]
  	Chess::Game.new(players).play
  end
end

s = Chess::Test.new.start_test

print "___ |_|_|_|
       _B2_|_|_|_|
       __ _|_|_|_|
       _|_|_|_|_|_|
       _|_|_|_|_|_|
       _|_|_|_|_|_|"