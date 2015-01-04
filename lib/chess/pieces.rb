module Chess
	class Piece
	  attr_reader
	  def initialize(input)	  	
	  end

	  def remove(destination)
		army.each do |p|
		  if p.present_position == destination
		  	p = nil
		  end
		end
	  end

	  def promote(type)
	  	#exchange piece for piece
	  end

	  def castling
	  	#ekhm..
	  end

	  def self.set_starting_position(army)
	  	pawn = { "white" => ["a2","b2","c2","d2","e2","f2","g2","h2"], "black" => ["a7","b7","c7","d7","e7","f7","g7","h7"]}
	  	rook = { "white" => ["a1","h1"], "black" => ["a8","h8"]}
	  	bishop = { "white" => ["c1","f1"], "black" => ["c8","f8"]}
	  	knight = { "white" => ["b1","g1"], "black" => ["b8","g8"]}
	  	queen = { "white" => ["d1"], "black" => ["d8"]}
	  	king = { "white" => ["e1"], "black" => ["e8"]}
	  	army.each do |piece|
  		if piece.type == "pawn"
	  	  pawn.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = pawn[key].pop
	  	   end
	  	  end
	  	elsif piece.type == "rook"
	  	  rook.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = rook[key].pop
	  	   end
	  	  end
	  	elsif piece.type == "bishop"
	  	  bishop.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = bishop[key].pop
	  	   end
	  	  end
	  	elsif piece.type == "knight"
	  	  knight.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = knight[key].pop
	  	   	 #knight[key].delete(0)
	  	   end
	  	  end
	  	elsif piece.type == "queen"
	  	  queen.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = queen[key].pop
	  	   end
	  	  end
	  	elsif piece.type == "king"
	  	  king.each_key do |key|
	  	   if key == piece.color
	  	   	 piece.start_position = king[key].pop
	  	   end
	  	  end
	  	end
	  	end
	  end

	  def self.set_id(army)
	  	army.each do |piece|
	  	  piece.id = piece.object_id
	  	end
	  end

	  def self.army
	  	army = []

	  	pawn = ["white", "white", "white", "white", "white", "white", "white", "white", "black", "black", "black", "black", "black", "black", "black", "black"]
	  	rook = ["white", "white", "black", "black"]
	  	bishop = ["white", "white", "black", "black"]
	  	knight = ["white", "white", "black", "black"]
	  	queen = ["white", "black"]
	  	king = ["white", "black"]
	  	
	  	16.times do |a|
	  	  color = pawn.pop
	  	  army << instance_variable_set("@p#{a}", Chess::Pawn.new(color: color))
	  	end
	  	4.times do |a|
	  	  color = rook.pop
	  	  army << instance_variable_set("@r#{a}", Chess::Rook.new(color: color))
	  	end
	  	4.times do |a|
	  	  color = bishop.pop
	  	  army << instance_variable_set("@b#{a}", Chess::Bishop.new(color: color))
	  	end
	  	4.times do |a|
	  	  color = knight.pop
	  	  army << instance_variable_set("@n#{a}", Chess::Knight.new(color: color))
	  	end
	  	2.times do |a|
	  	  color = queen.pop
	  	  army << instance_variable_set("@q#{a}", Chess::Queen.new(color: color))
	  	end
	  	2.times do |a|
	  	  color = king.pop
	  	  army << instance_variable_set("@k#{a}", Chess::King.new(color: color))
	  	end

	  	set_id(army)
	  	set_starting_position(army)
	  	army
	  end
	  
	end

	class King < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "king"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[1,0],[-1,0],[0,1],[0,-1],[-1,1],[1,-1],[1,1],[-1,-1]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  	@n_of_moves = 0
	  	@moves_made = []
	  end
	end

	class Queen < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "queen"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7],[-8,-8],[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],[8,-8],[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],[-8,8],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8],[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0],[-8,0],[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7],[0,-8]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  	@n_of_moves = 0
	  	@moves_made = []
	  end
	end

	class Rook < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "rook"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8],[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0],[-8,0],[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7],[0,-8]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  	@n_of_moves = 0
	  	@moves_made = []
	  end
	end

	class Bishop < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "bishop"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7],[-8,-8],[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],[8,-8],[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],[-8,8]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  	@n_of_moves = 0
	  	@moves_made = []
	  end
	end

	class Knight < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "knight"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[-2,-1],[-1,-2],[1,-2],[2,-1],[1,2],[2,1],[-1,2],[-2,1]]
	  	@attack = @move
	  	@name = "#{@color[0]}N"
	  	@n_of_moves = 0
	  	@moves_made = []
	  end
	end

	class Pawn < Piece
	  attr_reader :color, :type, :move, :attack, :name, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  attr_accessor :present_position, :start_position, :id, :possible_attack_destination, :n_of_moves, :moves_made, :possible_move_destination
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "pawn"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@possible_attack_destination = nil 
	  	@possible_move_destination = nil
	  	@move = [[2,0],[1,0],[-2,0],[-1,0]]
	  	@attack = [[-1,1],[1,-1],[1,1],[-1,-1]]
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  	@n_of_moves = 0
	  	@moves_made = []
	  	@en_passant = false
	  end
	end
end