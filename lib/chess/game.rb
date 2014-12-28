module Chess
  class Game
  	attr_reader :players, :board, :current_player, :other_player, :avalible_pieces

  	def initialize(players, board = Board.new, pieces = Piece.army)
  	  @players = players
  	  @board = board
      @avalible_pieces = pieces
      @current_player, @other_player = players[0], players[1]
  	end

  	def switch_players
  	  @current_player, @other_player = @other_player, @current_player
  	end

  	def solicit_move
  	  "#{current_player.name}, make your move!"
  	end

  	def game_over_message
  	  "#{current_player.name}: won the game!"
  	end

    def army_setup(army)
      #puts "start"
      avalible_pieces.each do |piece|
        #puts "getting #{piece}"
        #puts "#{piece.start_position}"
        x, y = human_move_to_coordinate(piece.start_position)
        board.set_cell(x, y, piece.name)
        piece.present_position = piece.start_position
      end
    end

    def select_piece(n_value)
      avalible_to_move = []
      avalible_pieces.each do |piece|
        if piece.name == n_value && piece.color == @current_player.color
          avalible_to_move << piece
        end
      end
      #puts "ile mamy pionkow o nazwie #{n_value} = #{avalible_to_move.size}"
      avalible_to_move
    end

    def select_piece_by_id(n_value)
      avalible_pieces.each do |piece|
        if piece.id == n_value
          return piece
        end
      end
    end

    def clean_after_move(position)
      x, y = human_move_to_coordinate(position)
      board.set_cell(x, y, "  ")
    end

    def clean_after_move_old(piece)
      p = select_piece(piece)
      unless p.present_position == nil
        x, y = human_move_to_coordinate(p.present_position)
        board.set_cell(x, y, "  ")
      end
    end

    def set_piece_pos(piece, position)
      p = select_piece(piece)
      p.present_position = position    
    end

    def check_avalible_moves(pieces, destination)
      valid_array = []
      if pieces.class == Array
        pieces.each do |p|
          #puts "valid_array.size = #{valid_array.size}"
          #puts "p is #{p}"
          #puts "p position is #{p.present_position}"
          position = human_move_to_coordinate(p.present_position)
          moves = p.move
          moves_array = []
          moves.size.times do |n|
            proposal = []
            proposal << (position[0] + moves[n-1][0])
            proposal << (position[1] + moves[n-1][1])
            n += 1
            if comp_move_to_human(proposal)
              moves_array << comp_move_to_human(proposal)
            end
          end
          if moves_array.include?(destination)
            #puts "destination jest w moves_array"
            valid_array << p
          end 
        end
        if valid_array.empty? 
          
          return
        end
      else
        puts "blad danych"
      end
      valid_array
    end

    def check_avalible_moves_t(piece, position2)
      if piece.class == String
        p = select_piece(piece)
      else
        p = piece
      end
      puts "p is #{p}"
      position = human_move_to_coordinate(position2)
      moves = p.move
      array = []
      moves.size.times do |n|
        proposal = []
        proposal << (position[0] + moves[n-1][0])
        proposal << (position[1] + moves[n-1][1])
        n += 1
        if comp_move_to_human(proposal)
          array << comp_move_to_human(proposal)
        end
      end
      array
    end

    def move(input)
      if input.include? :piece
        complicated_move(input)
      else
        simple_move(input)
      end
    end

    def next_move(input = gets.chomp)
      #possibilities = ["e4", "Ne4", "e7-f6", "Ng8-f6", "0-0", "0-0-0"]
      if input.size > 3
        puts "longer notation"
      else
        if input.size == 2
          complicated_move(piece: "P", destination: input)
        elsif input.size == 3
          complicated_move(piece: "#{input[0]}", destination: "#{input[1..2]}")
        else
          puts "this is not a valid move!"
        end
      end
    end

    def simple_move(input)
      destination = input.fetch(:destination)
      pInROfDestination = check_avalible_moves(avalible_pieces, destination)
      if pInROfDestination == nil
        puts "blad - zaden pionek nie moze wykonac takiego ruchu!!"
      elsif pInROfDestination.size <= 2
        the_piece = pInROfDestination[0]
        clean_after_move(the_piece.present_position)
        x, y = human_move_to_coordinate(destination)
        board.set_cell(x, y, the_piece.name)
        the_piece.present_position = destination
      else
        puts "please select piece to move"
      end
    end

    def complicated_move(input)
      piece = "#{@current_player.color[0]}#{input.fetch(:piece)}"
      destination = input.fetch(:destination)
      pInROfDestination = check_avalible_moves(select_piece(piece), destination)
      if pInROfDestination == nil
        puts "blad - zaden pionek nie moze wykonac takiego ruchu!!"
      elsif pInROfDestination.size <= 2
        the_piece = pInROfDestination[0]
        clean_after_move(the_piece.present_position)
        x, y = human_move_to_coordinate(destination)
        board.set_cell(x, y, piece)
        the_piece.present_position = destination
      else
        puts "please select piece to move"
      end
    end

  	def get_move(human_move = gets.chomp)
  	  human_move_to_coordinate(human_move)
  	end

  	def human_move_to_coordinate(human_move)
  	  mapping = {
  	   "a8" => [0, 0],
       "a7" => [1, 0],
       "a6" => [2, 0],
       "a5" => [3, 0],
       "a4" => [4, 0],
       "a3" => [5, 0],
       "a2" => [6, 0],
       "a1" => [7, 0],
       "b8" => [0, 1],
       "b7" => [1, 1],
       "b6" => [2, 1],
       "b5" => [3, 1],
       "b4" => [4, 1],
       "b3" => [5, 1],
       "b2" => [6, 1],
       "b1" => [7, 1],
       "c8" => [0, 2],
       "c7" => [1, 2],
       "c6" => [2, 2],
       "c5" => [3, 2],
       "c4" => [4, 2],
       "c3" => [5, 2],
       "c2" => [6, 2],
       "c1" => [7, 2],
       "d8" => [0, 3],
       "d7" => [1, 3],
       "d6" => [2, 3],
       "d5" => [3, 3],
       "d4" => [4, 3],
       "d3" => [5, 3],
       "d2" => [6, 3],
       "d1" => [7, 3],
       "e8" => [0, 4],
       "e7" => [1, 4],
       "e6" => [2, 4],
       "e5" => [3, 4],
       "e4" => [4, 4],
       "e3" => [5, 4],
       "e2" => [6, 4],
       "e1" => [7, 4],
       "f8" => [0, 5],
       "f7" => [1, 5],
       "f6" => [2, 5],
       "f5" => [3, 5],
       "f4" => [4, 5],
       "f3" => [5, 5],
       "f2" => [6, 5],
       "f1" => [7, 5],
       "g8" => [0, 6],
       "g7" => [1, 6],
       "g6" => [2, 6],
       "g5" => [3, 6],
       "g4" => [4, 6],
       "g3" => [5, 6],
       "g2" => [6, 6],
       "g1" => [7, 6],
       "h8" => [0, 7],
       "h7" => [1, 7],
       "h6" => [2, 7],
       "h5" => [3, 7],
       "h4" => [4, 7],
       "h3" => [5, 7],
       "h2" => [6, 7],
       "h1" => [7, 7],
     }
     mapping[human_move]
  	end

    def comp_move_to_human(comp_move)
      mapping = {
       [0, 0] => "a8",
       [1, 0] => "a7",
       [2, 0] => "a6",
       [3, 0] => "a5",
       [4, 0] => "a4",
       [5, 0] => "a3",
       [6, 0] => "a2",
       [7, 0] => "a1",
       [0, 1] => "b8",
       [1, 1] => "b7",
       [2, 1] => "b6",
       [3, 1] => "b5",
       [4, 1] => "b4",
       [5, 1] => "b3",
       [6, 1] => "b2",
       [7, 1] => "b1",
       [0, 2] => "c8",
       [1, 2] => "c7",
       [2, 2] => "c6",
       [3, 2] => "c5",
       [4, 2] => "c4",
       [5, 2] => "c3",
       [6, 2] => "c2",
       [7, 2] => "c1",
       [0, 3] => "d8",
       [1, 3] => "d7",
       [2, 3] => "d6",
       [3, 3] => "d5",
       [4, 3] => "d4",
       [5, 3] => "d3",
       [6, 3] => "d2",
       [7, 3] => "d1",
       [0, 4] => "e8",
       [1, 4] => "e7",
       [2, 4] => "e6",
       [3, 4] => "e5",
       [4, 4] => "e4",
       [5, 4] => "e3",
       [6, 4] => "e2",
       [7, 4] => "e1",
       [0, 5] => "f8",
       [1, 5] => "f7",
       [2, 5] => "f6",
       [3, 5] => "f5",
       [4, 5] => "f4",
       [5, 5] => "f3",
       [6, 5] => "f2",
       [7, 5] => "f1",
       [0, 6] => "g8",
       [1, 6] => "g7",
       [2, 6] => "g6",
       [3, 6] => "g5",
       [4, 6] => "g4",
       [5, 6] => "g3",
       [6, 6] => "g2",
       [7, 6] => "g1",
       [0, 7] => "h8",
       [1, 7] => "h7",
       [2, 7] => "h6",
       [3, 7] => "h5",
       [4, 7] => "h4",
       [5, 7] => "h3",
       [6, 7] => "h2",
       [7, 7] => "h1",
     }
     mapping[comp_move]
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
  	  puts "#{current_player.name} has #{current_player.color} pieces"
  	  while true
  	  	#board.formatted_grid
        board.print_board #
  	  	puts ""
  	  	puts solicit_move
  	  	next_move
  	  	#board.set_cell(x, y, current_player.color)
  	  	#if board.game_over
  	  	#  puts game_over_message
  	  	  #board.formatted_grid
  	  	#  return
  	  	#else
  	  	switch_players
  	  	#end
  	  end
  	end

  end
end