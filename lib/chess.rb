require_relative "chess/version"
require_relative "chess/player.rb"
require_relative "chess/board.rb"
require_relative "chess/game.rb"
require_relative "chess/load_save.rb"
require_relative "chess/pieces.rb"
require_relative "chess/square.rb"
require_relative "chess/knight_travails.rb"

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
  	  k.present_position = "d4"
  	  
  	  #b = Chess::Board.new
  	  g = Chess::Game.new([p, p2])
  	  Piece.set_id(k)
  	  #Piece.set_starting_position([k])


  	  #g.army_setup(g.avalible_pieces)
  	  #g.board.print_board
  	  #g.move(piece: "bk", destination: "c6")
  	  #g.board.print_board
  	  #g.move(piece: "bk", destination: "h6")
  	  #g.board.print_board
  	  #puts g.possible_moves("bk")
      p = g.select_piece("bk")
      puts "--------------------------"
      #puts g.check_avalible_moves("bk")
      full_board = ["a8","a7","a6","a5","a4","a3","a2","a1","b8","b7","b6","b5","b4","b3","b2","b1","c8","c7","c6","c5","c4","c3","c2","c1","d8","d7","d6","d5","d4","d3","d2","d1","e8","e7","e6","e5","e4","e3","e2","e1","f8","f7","f6","f5","f4","f3","f2","f1","g8","g7","g6","g5","g4","g3","g2","g1","h8","h7","h6","h5","h4","h3","h2","h1"]
      
      full_board2 = [[2, 7],[3, 7],[4, 7],[5, 7],[6, 7],[7, 7]]
      tree = Chess::Tree.new("test", g, k, g.board)
      #puts "  dddd  "
      #tree.board.print_board

      #tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
      #tree.read_tree
      #puts tree.depth_first_search(100, tree.rootnode)
      puts "--------------------------"
      tree.bt3("bk", "c3", full_board)
      puts "--------------------------"
      tree.bbranch[0].each do |element|
      	print "#{element.value}, "
      end
      puts "--------------------------"
      tree.bbranch[1].each do |element|
      	print "#{element.value}, "
      end
      #g.board.print_board
  	  #g.move(piece: "bk", destination: "f8")
  	  #puts g.select_piece("bk").present_position
  	  #g.board.print_board
  	  #puts g.select_piece("bk").type
  	  #puts g.methods

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
