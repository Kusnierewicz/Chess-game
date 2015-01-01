module Chess
  class Game
  	attr_reader :players, :board, :current_player, :other_player, :avalible_pieces, :check_mode

  	def initialize(players, board = Board.new, pieces = Piece.army)
  	  @players = players
  	  @board = board
      @avalible_pieces = pieces
      @current_player, @other_player = players[0], players[1]
      @check_mode = false
  	end

  	def switch_players
  	  @current_player, @other_player = @other_player, @current_player
  	end

  	def solicit_move
  	  "#{current_player.name}, make your move!"
  	end

    def army_setup(army)
      avalible_pieces.each do |piece|
        x, y = human_move_to_coordinate(piece.start_position)
        board.set_cell(x, y, piece.name)
        piece.present_position = piece.start_position
      end
    end

    def game_over
    end

    def game_over_message
      "#{current_player.name}: won the game!"
    end

    def activate_check_mode
      opponentKing = select_other_piece("#{@other_player.color[0]}K")
      destination = opponentKing[0].present_position
      #puts "opponent's king is on #{destination}"
      check = check_avalible_moves(avalible_pieces, destination)
      if check == false
        @check_mode = false
      else
        puts "Pieces that are checking the opponent King = #{check.inspect}"
        @check_mode = true
        puts "Check!"
      end
    end

    def select_piece(name)
      avalible_to_move = []
      avalible_pieces.each do |piece|
        if piece.name == name && piece.color == current_player.color
          avalible_to_move << piece
        end
      end
      avalible_to_move
    end

    def select_other_piece(name)
      avalible_to_move = []
      avalible_pieces.each do |piece|
        if piece.name == name && piece.color == other_player.color
          avalible_to_move << piece
        end
      end
      avalible_to_move
    end

    def select_piece_by_id(id)
      avalible_pieces.each do |piece|
        if piece.id == id
          return piece
        end
      end
    end

    def select_piece_by_present_position(position)
      avalible_pieces.each do |piece|
        if piece.present_position == position
          return piece
        end
      end
    end

    def delete_piece(position)
      avalible_pieces.each_with_index do |piece, index|
        if piece.present_position == position
          avalible_pieces.delete_at(index)
        end
      end
    end

    def delete_piece_by_id(id)
      avalible_pieces.each_with_index do |piece, index|
        if piece.id == id
          avalible_pieces.delete_at(index)
        end
      end
    end

    def clean_after_move(position)
      x, y = human_move_to_coordinate(position)
      board.set_cell(x, y, "  ")
    end

    def check_destination(destination)
      avalible_pieces.each do |piece|
        if piece.present_position == destination && piece.color == current_player.color
          return false
        end
      end
      return true
    end

    def check_pawn_move_destination(destination)
      avalible_pieces.each do |piece|
        if piece.present_position == destination
          return false
        end
      end
      return true
    end

    def check_pawn_attack_destination(destination)
      avalible_pieces.each do |piece|
        if piece.present_position == destination && piece.color != current_player.color
          return true
        end
      end
      return false
    end

    def check_if_move_ok(origin, destination)
      p = select_piece_by_present_position(origin)
      if p.color == current_player.color
        position = human_move_to_coordinate(p.present_position)
        moves = p.move
        if p.type == "pawn" && p.n_of_moves > 0
          moves -= [[2,0],[-2,0]]
        end
        if p.type == "pawn" && p.color == "white"
          moves -= [[2,0],[1,0]]
        elsif p.type == "pawn" && p.color == "black"
          moves -= [[-2,0],[-1,0]]
        end
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
          return true
        end 
      end
    end

    def check_if_pawn_attack_ok(origin, destination)
      p = select_piece_by_present_position(origin)
      if p.color == current_player.color
        position = human_move_to_coordinate(p.present_position)
        moves = p.attack
        if p.color == "white"
          moves -= [[1,-1],[1,1]]
        else
          moves -= [[-1,1],[-1,-1]]
        end
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
          return true
        end 
      end
    end

    def check_avalible_moves(pieces, destination)
      valid_array = []
      if pieces.class == Array
        pieces.each do |p|
          if p.color == current_player.color
            position = human_move_to_coordinate(p.present_position)
            moves = p.move
            if p.type == "pawn" && p.n_of_moves > 0
              moves -= [[2,0],[-2,0]]
            end
            if p.type == "pawn" && p.color == "white"
              moves -= [[2,0],[1,0]]
            elsif p.type == "pawn" && p.color == "black"
              moves -= [[-2,0],[-1,0]]
            end
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
              valid_array << p
            end 
          end
        end
        if valid_array.empty? 
          return false
        end
      else
        puts "blad danych"
      end
      valid_array
    end

    def check_pawn_attack(pieces, destination)
      if check_pawn_attack_destination(destination)
        valid_array = []
        if pieces.class == Array
          pieces.each do |p|
            position = human_move_to_coordinate(p.present_position)
            moves = p.attack
            if p.color == "white"
              moves -= [[1,-1],[1,1]]
            else
              moves -= [[-1,1],[-1,-1]]
            end
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
              valid_array << p
            end 
          end
          if valid_array.empty? 
            
            return false
          end
        else
          puts "blad danych"
        end
        valid_array
      else
        return false
      end
    end

    def check_pawn_promotion
      promo_positions = ["1","8"]
      avalible_pieces.each do |p|
        if p.moves_made.empty? == false
          if p.type == "pawn" && promo_positions.include?(p.moves_made[-1][1])
            puts "avalible promotion!"
            pawn_promotion(p)
          end
        end
      end
    end

    def pawn_promotion(pawn)
      puts "please select piece for promotion (r - rook, b - bishop, n - knight, q - queen)"
      input = gets.chomp.downcase
      case
      when input == "r"
        piece = Chess::Rook.new(color: current_player.color)
        set_new_piece(piece, pawn)
      when input == "b"
        piece = Chess::Bishop.new(color: current_player.color)
        set_new_piece(piece, pawn)
      when input == "n"
        piece = Chess::Knight.new(color: current_player.color)
        set_new_piece(piece, pawn)
      when input == "q"
        piece = Chess::Queen.new(color: current_player.color)
        set_new_piece(piece, pawn)
      else
        puts "what? Try again, use first letter of a figure (r, b, n (for knight), q)"
        pawn_promotion(pawn)
      end
    end

    def set_new_piece(n_piece, o_piece)
      n_piece.id = n_piece.object_id
      n_piece.start_position = o_piece.present_position
      n_piece.present_position = o_piece.present_position
      avalible_pieces.push(n_piece)
      x, y = human_move_to_coordinate(n_piece.present_position)
      board.set_cell(x, y, n_piece.name)
      delete_piece_by_id(o_piece.id)
    end

    def check_castling(version)
      if current_player.color == "white"
        row = 1
      else
        row = 8
      end
      if version == "long"
        k = select_piece_by_present_position("e#{row}")
        r = select_piece_by_present_position("a#{row}")
      elsif version == "short"
        k = select_piece_by_present_position("e#{row}")
        r = select_piece_by_present_position("h#{row}")
      end
      if k.class == King && r.class == Rook
        if k.n_of_moves == 0 && r.n_of_moves == 0
          return true
        else
          return false
        end
      else
        return false
      end
    end

    def castling(version)
      puts "castling!"
    end

    def next_move(input = gets.chomp)
      #possibilities = ["e4", "Ne4", "e7-f6", "Ng8-f6", "0-0", "0-0-0"]
      if input[0] == "0"
        if input.size == 5
          if check_castling("long")
            puts castling("long")
            return true
          else
            return false
          end
        elsif input.size == 3
          if check_castling("short")
            puts castling("short")
            return true
          else
            return false
          end
        else
          puts "this is not a valid move!"
          return false
        end
      elsif input[0] != 0 && input.size > 3
        puts "longer notation"
        if input.size == 5
          pawn_move(piece: "P", destination: "#{input[3..4]}", origin: "#{input[0..1]}")
        elsif input.size == 6
          all_move(piece: "#{input[0]}", destination: "#{input[4..5]}", origin: "#{input[1..2]}")
        else
          puts "this is not a valid move!"
          return false
        end
      elsif input[0] != 0 && input.size <= 3
        if input.size == 2
          pawn_move(piece: "P", destination: input)
        elsif input.size == 3
          all_move(piece: "#{input[0]}", destination: "#{input[1..2]}")
        else
          puts "this is not a valid move!"
          return false
        end
      end
    end

    def pawn_move(input)
      piece = "#{@current_player.color[0]}#{input.fetch(:piece)}"
      destination = input.fetch(:destination)
      if input.include?(:origin)
        if select_piece_by_present_position(:origin).name == piece
          origin = input.fetch(:origin)
        else
          return false
        end
        if check_if_move_ok(origin, destination)
          if check_destination(destination)
            delete_piece(destination)
            the_piece = select_piece_by_present_position(origin)
            clean_after_move(the_piece.present_position)
            x, y = human_move_to_coordinate(destination)
            board.set_cell(x, y, piece)
            the_piece.present_position = destination
            the_piece.moves_made.push(destination)
            the_piece.n_of_moves += 1
            return true
          else
            return false
          end
        elsif check_if_pawn_attack_ok(origin, destination)
          if check_pawn_attack_destination(destination)
            delete_piece(destination)
            the_piece = select_piece_by_present_position(origin)
            clean_after_move(the_piece.present_position)
            x, y = human_move_to_coordinate(destination)
            board.set_cell(x, y, piece)
            the_piece.present_position = destination
            the_piece.moves_made.push(destination)
            the_piece.n_of_moves += 1
            return true
          else
            return false
          end
        else
          return false
        end
      end
      pInROfDestination = check_avalible_moves(select_piece(piece), destination)
      if pInROfDestination == false
        pInROfDestination = check_pawn_attack(select_piece(piece), destination)
        if pInROfDestination == false
          #puts "blad - zaden pionek nie moze wykonac takiego ruchu!!"
          return false
        elsif pInROfDestination.size == 1
          if check_pawn_attack_destination(destination)
            delete_piece(destination)
            the_piece = pInROfDestination[0]
            clean_after_move(the_piece.present_position)
            x, y = human_move_to_coordinate(destination)
            board.set_cell(x, y, piece)
            the_piece.present_position = destination
            the_piece.moves_made.push(destination)
            the_piece.n_of_moves += 1
            return true
          else
            #puts "nie mozesz atakowac pustego pola pionkiem ani ustawiac dwoch pionkow na jednym miejscu"
            return false
          end
        elsif pInROfDestination.size > 1 
          if check_pawn_attack_destination(destination)
            puts "wiecej niz 1 pionek moze sie ruszyc na wybrane pole. Uzyj raz jeszcze dluzszej komendy np. 'e7-f6', 'Ng8-f6'"
            return false
          else
            #puts "please select piece to move"
            return false
          end
        end
      elsif pInROfDestination.size == 1
        if check_pawn_move_destination(destination)
          delete_piece(destination)
          the_piece = pInROfDestination[0]
          clean_after_move(the_piece.present_position)
          x, y = human_move_to_coordinate(destination)
          board.set_cell(x, y, piece)
          the_piece.present_position = destination
          the_piece.moves_made.push(destination)
          the_piece.n_of_moves += 1
          return true
        else
          return false
        end
      elsif pInROfDestination.size > 1 
        if check_pawn_move_destination(destination)
          puts "wiecej niz 1 pionek moze sie ruszyc na wybrane pole. Uzyj raz jeszcze dluzszej komendy np. 'e7-f6', 'Ng8-f6'"
          return false
        else
        #puts "please select piece to move"
          return false
        end
      end
    end

    def all_move(input)
      piece = "#{@current_player.color[0]}#{input.fetch(:piece)}"
      destination = input.fetch(:destination)
      if input.include?(:origin)
        origin = input.fetch(:origin)
        if check_destination(destination)
          delete_piece(destination)
          the_piece = select_piece_by_present_position(origin)
          clean_after_move(the_piece.present_position)
          x, y = human_move_to_coordinate(destination)
          board.set_cell(x, y, piece)
          the_piece.present_position = destination
          the_piece.moves_made.push(destination)
          the_piece.n_of_moves += 1
          return true
        else
          return false
        end
      end
      pInROfDestination = check_avalible_moves(select_piece(piece), destination)
      if pInROfDestination == nil 
        return false
      elsif pInROfDestination.size == 1
        if check_destination(destination)
          delete_piece(destination)
          the_piece = pInROfDestination[0]
          clean_after_move(the_piece.present_position)
          x, y = human_move_to_coordinate(destination)
          board.set_cell(x, y, piece)
          the_piece.present_position = destination
          the_piece.moves_made.push(destination)
          the_piece.n_of_moves += 1
          return true
        else
          #puts "nie mozesz miec dwoch figur na jednym polu"
          return false
        end
      elsif pInROfDestination.size > 1
        if check_destination(destination)
          puts "wiecej niz 1 pionek moze sie ruszyc na wybrane pole. Uzyj raz jeszcze dluzszej komendy np. 'e7-f6', 'Ng8-f6'"
          return false
        else
        #puts "please select piece to move"
          return false
        end
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
        board.print_board 
  	  	puts ""
  	  	puts solicit_move

  	  	r = next_move
        while r != true
          puts "to nie jest poprawny ruch - sprobuj ponownie"
          r = next_move
        end
        activate_check_mode
        check_pawn_promotion
        
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