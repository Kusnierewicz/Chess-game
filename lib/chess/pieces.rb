module Chess
	class Piece
	  attr_reader
	  def initialize(input)
	  	
	  end

	  def self.possible_moves(type)

	  end

	  def possible_attacks
	  	puts @attack
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
	  	bishop = { "white" => ["c1","f1"], "black" => ["c8","g8"]}
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

	  def self.set_id(piece)
	  	piece.id = piece.object_id
	  end

	  def self.army
	  	army = []
	  	k = Chess::Knight.new(color: "black")
	  	set_id(k)
	  	#k2 = Chess::Knight.new(color: "black")	  	
	  	army << k
	  	#army << k2
	  	set_starting_position(army)
	  	army
	  end
	  
	end

	class King < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "king"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@move = [[1,0],[-1,0],[0,1],[0,-1],[-1,1],[1,-1],[1,1],[-1,-1]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Queen < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "queen"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Rook < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "rook"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Bishop < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "bishop"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@move = nil
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Knight < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "knight"
	  	@id = nil
	  	@start_position = nil
	  	@present_position = nil
	  	@move = [[-2,-1],[-1,-2],[1,-2],[2,-1],[1,2],[2,1],[-1,2],[-2,1]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0]}"
	  end
	end

	class Pawn < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position, :id
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "pawn"
	  	@id = nil
	  	@start_position = "a2"
	  	@present_position = nil
	  	@move = [[2,0],[1,0],[-2,0],[-1,0],[-1,1],[1,-1],[1,1],[-1,-1]]
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end
end