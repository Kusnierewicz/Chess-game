module Chess
  class Board
  	attr_reader :grid

  	def initialize(input = {})
  	  @grid = input.fetch(:grid, default_grid)
  	end

  	def get_cell(x, y)
  	  grid[y][x]
  	end

  	def set_cell(x, y, value)
  	  get_cell(x, y).value = value
  	end

  	def default_grid
  	  Array.new(8) { Array.new(8) { Square.new }}
  	end

    def print_board
      puts "   A  B  C  D  E  F  G  H  "
      puts "  -------------------------"
      puts "8 |#{@grid[0][0].value}|#{@grid[1][0].value}|#{@grid[2][0].value}|#{@grid[3][0].value}|#{@grid[4][0].value}|#{@grid[5][0].value}|#{@grid[6][0].value}|#{@grid[7][0].value}|"
      puts "  -------------------------"
      puts "7 |#{@grid[0][1].value}|#{@grid[1][1].value}|#{@grid[2][1].value}|#{@grid[3][1].value}|#{@grid[4][1].value}|#{@grid[5][1].value}|#{@grid[6][1].value}|#{@grid[7][1].value}|       Pieces taken: Px1, Bx2"
      puts "  -------------------------"
      puts "6 |#{@grid[0][2].value}|#{@grid[1][2].value}|#{@grid[2][2].value}|#{@grid[3][2].value}|#{@grid[4][2].value}|#{@grid[5][2].value}|#{@grid[6][2].value}|#{@grid[7][2].value}|          Time left: 30:00"
      puts "  -------------------------"
      puts "5 |#{@grid[0][3].value}|#{@grid[1][3].value}|#{@grid[2][3].value}|#{@grid[3][3].value}|#{@grid[4][3].value}|#{@grid[5][3].value}|#{@grid[6][3].value}|#{@grid[7][3].value}|"
      puts "  -------------------------"
      puts "4 |#{@grid[0][4].value}|#{@grid[1][4].value}|#{@grid[2][4].value}|#{@grid[3][4].value}|#{@grid[4][4].value}|#{@grid[5][4].value}|#{@grid[6][4].value}|#{@grid[7][4].value}|"
      puts "  -------------------------"
      puts "3 |#{@grid[0][5].value}|#{@grid[1][5].value}|#{@grid[2][5].value}|#{@grid[3][5].value}|#{@grid[4][5].value}|#{@grid[5][5].value}|#{@grid[6][5].value}|#{@grid[7][5].value}|"
      puts "  -------------------------"
      puts "2 |#{@grid[0][6].value}|#{@grid[1][6].value}|#{@grid[2][6].value}|#{@grid[3][6].value}|#{@grid[4][6].value}|#{@grid[5][6].value}|#{@grid[6][6].value}|#{@grid[7][6].value}|       Pieces taken: Px1, Bx2"
      puts "  -------------------------"
      puts "1 |#{@grid[0][7].value}|#{@grid[1][7].value}|#{@grid[2][7].value}|#{@grid[3][7].value}|#{@grid[4][7].value}|#{@grid[5][7].value}|#{@grid[6][7].value}|#{@grid[7][7].value}|          Time left: 30:00"
      puts "  -------------------------"
    end

  end
end