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

	  def set_starting_position(piece)
	  	white pawn = ["a2","b2","c2","d2","e2","f2","g2","h2"]
	  	black pawn = ["a7","b7","c7","d7","e7","f7","g7","h7"]
	  	white rook = ["a1","h1"]
	  	black rook = ["a8","h8"]
	  	white bishop = ["c1","f1"]
	  	black bishop = ["c8","f8"]
	  	white knight = ["b1","g1"]
	  	black knight = ["b8","g8"]
	  	white queen = ["d1"]
	  	black queen = ["d8"]
	  	white king = ["e1"]
	  	black king = ["e8"]

	  end

	  def self.army
	  	army = []
	  	k = Chess::Knight.new(color: "black")
	  	army << k
	  	army
	  end
	  
	end

	class King < Piece
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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
	  attr_reader :color, :type, :start_position, :move, :name
	  attr_accessor :present_position
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