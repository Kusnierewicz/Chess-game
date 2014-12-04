
module Chess
	class Node
	  attr_accessor :id, :value, :leftchild, :rightchild, :rootnode, :parent, :children

	  def initialize(value)
		  @id = nil
		  @value = value
		  @leftchild = nil
		  @rightchild = nil
		  @rootnode = nil
		  @parent = nil
		  @children = []
	  end

	  def set_parent(parent)
		self.parent = parent.id
	  end

	  def set_child(child)
		self.value > child.value ? self.leftchild = child.id : self.rightchild = child.id
		return
	  end

	  def set_root
		self.rootnode = true
	  end

	end

  class Tree
  	attr_accessor :game, :piece, :board

  	def initialize(name, game, piece, board)
  	  @name = name
  	  @game = game
  	  @piece = piece
  	  @board = board
  	  @branch = []
  	end

  	def build_tree(arr)
  	  @branch = []

  	  arr.each_with_index do |element, index|
  	  	if @branch.empty? 
  	  	  @noderoot = Chess::Node.new(element)
  	  	  @noderoot.set_root
  	  	  @noderoot.id = @noderoot.object_id
  	  	  @branch << @noderoot
  	  	else
  	  	  @branch << instance_variable_set("@node#{index}", Chess::Node.new(element))
  	  	  @branch.last.id = @branch.last.object_id
  	  	  add_to_tree(@branch.last, @noderoot)
  	  	end
  	  end
	end

	def set_board
	  puts @game.inspect
	  puts @piece.inspect
	  puts @board.inspect
	end



	def bt(piece, position, avalible_moves)
	  if avalible_moves.empty?
	  	puts "avalible_moves empty"
	  	return @branch
	  elsif @branch.empty?
	  	puts "branch is empty"
	  	node0 = Chess::Node.new(position)
	  	puts "node0 value = #{node0.value}"
	  	node0.id = node0.object_id
	  	@branch << node0
	  	puts "#{@branch.inspect}"
	  	puts "#{avalible_moves.size}"
	  	avalible_moves.delete(position)
	  	puts "#{avalible_moves.size}"
	  else
	  	puts "branch and avalible_moves not empty"
	  	@branch << instance_variable_set("@node#{@branch.size}", Chess::Node.new(element))
	  	@branch.last.id = @branch.last.object_id
		arr = game.check_avalible_moves(piece)
	  	puts "arr = #{arr.inspect}"

	  end



	def start_sequence(piece, moves)
	  p = game.select_piece(piece)
	  position = p.present_position
	  build_sequence_tree(piece, position, moves)
	end


	def build_sequence_tree(piece, position, avalible_moves, branch = [])
	  if branch.empty?
	  	puts "branch is empty"
	  	puts "piece position = #{position}"
	  	node0 = Chess::Node.new(position)
	  	puts "node0 value = #{node0.value}"
	  	node0.id = node0.object_id
	  	branch << node0
	  	puts "#{branch.inspect}"
	  	puts "#{avalible_moves.size}"
	  	avalible_moves.delete(position)
	  	puts "#{avalible_moves.size}"
	  end
	  game.set_piece_pos(piece, position)
	  arr = game.check_avalible_moves(piece)
	  puts "arr = #{arr.inspect}"
	  
	  if avalible_moves.empty? != true
	  	
	  	arr.each_with_index do |element, index|
	  	  if avalible_moves.include?(element)
	  	  	branch << instance_variable_set("@node#{branch.size}", Chess::Node.new(element))
	  	  	branch.last.id = branch.last.object_id
	  	  	if piece.class == String
	  	  	  node0.children << branch.last.id
	  	  	  branch.last.parent = node0.id
	  	  	else
	  	  	  piece.children << branch.last.id
	  	  	  branch.last.parent = piece.id
	  	  	end
	  	  	
	  	  	#puts "piece id = #{piece.id}"
	  	  	puts "branch.last.inspect = #{branch.last.inspect}"
	  	  	puts "piece class = #{piece.class}"
	  	  	
	  	  		
	  	  	
	  	  	avalible_moves.delete(element)
	  	  	puts "branch size = #{branch.size}"
	  	  	puts "#{branch.last.value.inspect}"
	  	  	#build_sequence_tree(piece, branch.last.value, avalible_moves, branch)
	  	  else
	  	  	puts "#{element} is not in avalible_moves"
	  	  end
	  	end
  	  end
  	  print "branch = #{branch.inspect}"
	end

	def add_to_tree(new_node, parent_node)
	  if new_node.value >= parent_node.value
  	  	if parent_node.rightchild == nil
  	  	  parent_node.set_child(new_node)
  	  	  new_node.set_parent(parent_node)
  	  	else
  	  	  add_to_tree(new_node, select_node(parent_node.rightchild))
  	  	end
  	  elsif new_node.value < parent_node.value
  	  	if parent_node.leftchild == nil
  	  	  parent_node.set_child(new_node)
  	  	  new_node.set_parent(parent_node)
  	  	else
  	  	  add_to_tree(new_node, select_node(parent_node.leftchild))
  	  	end
  	  end
	end

	def select_node(n_value)
	  @branch.each_with_index do |element, index|
	  	if element.id == n_value
	  	  return element
	  	end
	  end
	end

	def breadth_first_search(target, node, queue = [], checked = [])
	  if queue.empty? && checked.empty? == false
	    return nil
	  else
	  	if node.rootnode == true
	  	  if node.value == target
	  	    puts "Searched value is: #{queue.last.value}!!!"
	        result = node
	        return result
	      else
	        checked << node.id	        
			if node.leftchild != nil && checked.include?(node.leftchild) == false
			  position = select_node(node.leftchild)
			  if position.value == target
	            result = position
	            return result
			  else
			  	checked << position.id
	            queue.push(position.id)
	          end
	        end

		  	if node.rightchild != nil && checked.include?(node.rightchild) == false
		  	  position = select_node(node.rightchild)
			  if position.value == target
	  	        puts "Searched value is: #{position.value}!!!"
	  	        result = position
	            return result
			  else
			  	checked << position.id
	            queue.push(position.id)
	          end
	        end
	        breadth_first_search(target, select_node(queue[0]), queue, checked)
		  end
	    else        
		  if node.leftchild != nil && checked.include?(node.leftchild) == false
		    position = select_node(node.leftchild)
		    if position.value == target
  	          puts "Searched value is: #{position.value}!!!"
              result = position
              return result
		    else
		      checked << position.id
              queue.push(position.id)
            end
          end

	  	  if node.rightchild != nil && checked.include?(node.rightchild) == false
	  	    position = select_node(node.rightchild)
		    if position.value == target
  	          puts "Searched value is: #{position.value}!!!"
  	          result = position
              return result
		    else
		  	  checked << position.id
              queue.push(position.id)
            end
          end
	  	  queue.delete(queue[0])
	  	  breadth_first_search(target, select_node(queue[0]), queue, checked)
	    end
	  end

	end

	def depth_first_search(target, node, stack = [], checked = [])
	  stack << node
	  until stack.empty? && checked.empty? != true
	  	if checked.include?(stack.last)
		  if stack.last.rightchild != nil && checked.include?(stack.last.rightchild) == false
		  	 stack << select_node(stack.last.rightchild)
		  else 
		  	 stack.delete(stack[-1])
		  end
		else 
		  checked << stack.last.id
		  if stack.last.value == target
			  puts "Searched value is: #{stack.last.value}!!!"
			  result = stack.last
			  return result
	  	  elsif stack.last.leftchild != nil && checked.include?(stack.last.leftchild) == false
		  	 stack << select_node(stack.last.leftchild)
		  elsif stack.last.rightchild != nil && checked.include?(stack.last.rightchild) == false
		  	 stack << select_node(stack.last.rightchild)
		  else 
		  	 stack.delete(stack[-1])
		  end
		end
	  end
	end

	def dfs(target, node, stack = [], checked = [])
	    if stack.empty? && checked.empty? == false

	      return result
	    else
	      if checked.include?(node)
			if stack.last.leftchild != nil && checked.include?(stack.last.leftchild) == false
		  	  dfs(target, select_node(stack.last.leftchild), stack, checked)

		  	elsif stack.last.rightchild != nil && checked.include?(stack.last.rightchild) == false
		  	  dfs(target, select_node(stack.last.rightchild), stack, checked)

		  	else 
		  	  stack.delete(stack[-1])
		  	  if stack.empty?
		  	   	return result
		  	  else
		  	    dfs(target, select_node(stack.last.id), stack, checked)
		  	  end

		  	end

	      else
	      	stack << node
	      	checked << stack.last.id
			if stack.last.value == target
			  puts "Searched value is: #{stack.last.value}!!!"
			  result = stack.last

			elsif stack.last.leftchild != nil && checked.include?(stack.last.leftchild) == false
		  	  dfs(target, select_node(stack.last.leftchild), stack, checked)

		  	elsif stack.last.rightchild != nil && checked.include?(stack.last.rightchild) == false
		  	  dfs(target, select_node(stack.last.rightchild), stack, checked)

		  	else
			  stack.delete(stack[-1])
		  	  if stack.empty?
		  	   	return result
		  	  else
		  	    dfs(target, select_node(stack.last.id), stack, checked)
		  	  end

		  	end
		  end
		end
	end

	def rootnode
	  @branch[0]
	end

	def read_tree
	  @branch.each do |element|
	  	puts element.inspect
	  end
	end

  end

end

=begin
tree = BasicDataStructures::Tree.new("test")

tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts " "
print "----------------reading tree----------------------"
puts " "
puts " "
tree.read_tree
puts " "
print "----------------stop reading tree-----------------"
puts " "

puts tree.depth_first_search(100, tree.rootnode)
puts tree.depth_first_search(6345, tree.rootnode)
puts tree.depth_first_search(324, tree.rootnode)
puts tree.depth_first_search(23, tree.rootnode)
puts tree.depth_first_search(8, tree.rootnode)

print "----------------stop reading tree-----------------"

puts tree.breadth_first_search(100, tree.rootnode)
puts tree.breadth_first_search(6345, tree.rootnode)
puts tree.breadth_first_search(324, tree.rootnode)
puts tree.breadth_first_search(23, tree.rootnode)
puts tree.breadth_first_search(8, tree.rootnode)

print "----------------stop reading tree-----------------"

puts tree.dfs(100, tree.rootnode)
puts tree.dfs(6345, tree.rootnode)
puts tree.dfs(324, tree.rootnode)
puts tree.dfs(23, tree.rootnode)
puts tree.dfs(8, tree.rootnode)
=end
