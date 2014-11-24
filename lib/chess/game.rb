module Chess
  class Game
  	attr_reader :players, :board, :current_player, :other_player, :avalible_pieces

  	def initialize(players, board = Board.new, pieces = Piece.army)
  	  @players = players
  	  @board = board
  	  @current_player, @other_player = players.shuffle
      @avalible_pieces = pieces
  	end

  	def switch_players
  	  @current_player, @other_player = @other_player, @current_player
  	end

  	def solicit_move
  	  "#{current_player.name}: Enter a number between 1 and 9 to make your move"
  	end

  	def game_over_message
  	  "#{current_player.name}: won the game!"
  	end

    def select_piece(n_value)
      @avalible_pieces.each do |piece|
        if piece.name == n_value
          return piece
        end
      end
    end

    def set_piece_pos(piece, position)
      p = select_piece(piece)
      p.present_position = position    
    end

    def move(input)
      piece = input.fetch(:piece)
      destination = input.fetch(:destination)
      x, y = human_move_to_coordinate(destination)
      board.set_cell(x, y, piece)
      set_piece_pos(piece, destination)
    end

  	def get_move(human_move = gets.chomp)
  	  human_move_to_coordinate(human_move)
  	end

  	def human_move_to_coordinate(human_move)
  	  mapping = {
  	   "a8" => [0, 0],
       "b8" => [1, 0],
       "c8" => [2, 0],
       "d8" => [3, 0],
       "e8" => [4, 0],
       "f8" => [5, 0],
       "g8" => [6, 0],
       "h8" => [7, 0],
       "a7" => [0, 1],
       "b7" => [1, 1],
       "c7" => [2, 1],
       "d7" => [3, 1],
       "e7" => [4, 1],
       "f7" => [5, 1],
       "g7" => [6, 1],
       "h7" => [7, 1],
       "a6" => [0, 2],
       "b6" => [1, 2],
       "c6" => [2, 2],
       "d6" => [3, 2],
       "e6" => [4, 2],
       "f6" => [5, 2],
       "g6" => [6, 2],
       "h6" => [7, 2],
       "a5" => [0, 3],
       "b5" => [1, 3],
       "c5" => [2, 3],
       "d5" => [3, 3],
       "e5" => [4, 3],
       "f5" => [5, 3],
       "g5" => [6, 3],
       "h5" => [7, 3],
       "a4" => [0, 4],
       "b4" => [1, 4],
       "c4" => [2, 4],
       "d4" => [3, 4],
       "e4" => [4, 4],
       "f4" => [5, 4],
       "g4" => [6, 4],
       "h4" => [7, 4],
       "a3" => [0, 5],
       "b3" => [1, 5],
       "c3" => [2, 5],
       "d3" => [3, 5],
       "e3" => [4, 5],
       "f3" => [5, 5],
       "g3" => [6, 5],
       "h3" => [7, 5],
       "a2" => [0, 6],
       "b2" => [1, 6],
       "c2" => [2, 6],
       "d2" => [3, 6],
       "e2" => [4, 6],
       "f2" => [5, 6],
       "g2" => [6, 6],
       "h2" => [7, 6],
       "a1" => [0, 7],
       "b1" => [1, 7],
       "c1" => [2, 7],
       "d1" => [3, 7],
       "e1" => [4, 7],
       "f1" => [5, 7],
       "g1" => [6, 7],
       "h1" => [7, 7],
     }
     mapping[human_move]
  	end

    def run
      puts "welcome to Chess Game!!!"
      command = ""
      while command != "q"
        printf "enter command: "
        input = gets.chomp
        parts = input.split(" ")
        command = parts[0]
        case command
          when 't' then tweet(parts[1..-1].join(" "))
          when 'q' then puts "Goodbye!"
          when 'dm' then dm(parts[1], parts[2..-1].join(" "))
          when 'fl' then followers_list
          else
            puts "Sorry, I don't know how to #{command}"
        end 
      end
    end

  	def play
  	  puts "#{current_player.name} has randomly been selected as the first player"
  	  while true
  	  	#board.formatted_grid
  	  	puts ""
  	  	puts solicit_move
  	  	x, y = get_move
  	  	board.set_cell(x, y, current_player.color)
  	  	if board.game_over
  	  	  puts game_over_message
  	  	  #board.formatted_grid
  	  	  return
  	  	else
  	  	  switch_players
  	  	end
  	  end
  	end

  end
end