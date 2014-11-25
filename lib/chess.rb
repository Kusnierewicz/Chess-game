require_relative "chess/version"
require_relative "chess/player.rb"
require_relative "chess/board.rb"
require_relative "chess/game.rb"
require_relative "chess/load_save.rb"
require_relative "chess/pieces.rb"
require_relative "chess/square.rb"

module Chess

  
  class Test
  	def initialize
    #@player = Player.new
    #@password = Password.new
    #@round = 1
    end
    def start_test
  	  puts "Welcome to chess game"
  	  p = Chess::Player.new(color: "black", name: "Luk")
  	  p2 = Chess::Player.new(color: "white", name: "Poul")
  	  k = Chess::Knight.new(color: "black")
  	  #b = Chess::Board.new
  	  g = Chess::Game.new([p, p2])
  	  g.board.print_board
  	  g.move(piece: "bk", destination: "e8")
      puts g.select_piece("bk").present_position
      g.board.print_board
  	  g.move(piece: "bk", destination: "f8")
  	  puts g.select_piece("bk").present_position
  	  g.board.print_board

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
