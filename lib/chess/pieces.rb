module Chess
	class Piece
	  attr_reader
	  def initialize(input)
	  	
	  end

	  def possible_moves
	  	puts @move
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

	  def self.set_starting_position(piece)
	  	pawn = { "white" => ["a2","b2","c2","d2","e2","f2","g2","h2"], "black" => ["a7","b7","c7","d7","e7","f7","g7","h7"]}
	  	rook = { "white" => ["a1","h1"], "black" => ["a8","h8"]}
	  	bishop = { "white" => ["c1","f1"], "black" => ["c8","g8"]}
	  	knight = { "white" => ["b1","g1"], "black" => ["b8","g8"]}
	  	queen = { "white" => ["d1"], "black" => ["d8"]}
	  	king = { "white" => ["e1"], "black" => ["e8"]}
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
	  	   	 piece.start_position = knight[key][0]
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

	  def self.army
	  	army = []
	  	k = Chess::Knight.new(color: "black")
	  	k2 = Chess::Knight.new(color: "black")
	  	set_starting_position(k)
	  	set_starting_position(k2)
	  	army << k
	  	army << k2
	  	army
	  end
	  
	end

	class King < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "king"
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Queen < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "queen"
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Rook < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "rook"
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Bishop < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "bishop"
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end

	class Knight < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "knight"
	  	@start_position = nil
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0]}"
	  end
	end

	class Pawn < Piece
	  attr_reader :color, :type, :move, :name
	  attr_accessor :present_position, :start_position
	  def initialize(input)
	  	@color = input.fetch(:color)
	  	@type = "pawn"
	  	@start_position = "a2"
	  	@present_position = nil
	  	@move = "two ahead one on the side"
	  	@attack = @move
	  	@name = "#{@color[0]}#{@type[0].upcase}"
	  end
	end
end