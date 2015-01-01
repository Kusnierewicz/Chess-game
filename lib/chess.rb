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
    end
    
    def start_test
  	  puts "Welcome to chess game"
  	  p2 = Chess::Player.new(color: "black", name: "Luk")
  	  p = Chess::Player.new(color: "white", name: "Poul")
  	  g = Chess::Game.new([p, p2])

      puts g.avalible_pieces
      puts g.avalible_pieces[1].start_position

  	  g.army_setup(g.avalible_pieces)

      p = g.select_piece("bk")
      puts "--------------------------"
      g.board.print_board
  	  g.board.print_board

      g.move(piece: "wN", destination: "c3", color: "white")
      puts "--------------------------"

      g.board.print_board

    end

    def start_game
      puts "Welcome to chess game"
      bob = Chess::Player.new({color: "white", name: "bob"})
      frank = Chess::Player.new({color: "black", name: "frank"})
      players = [bob, frank]
      g = Chess::Game.new(players)
      #puts g.check_mode
      #g.change_check_mode
      #puts g.check_mode
      #puts g.avalible_pieces.inspect
      g.army_setup(g.avalible_pieces)
      g.play
    end

  end

  
end

s = Chess::Test.new.start_game
