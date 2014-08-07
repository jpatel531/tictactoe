require_relative 'player'
require_relative 'board'

class Computer < Player

	def initialize
		@marker = "O"
	end

	def block_opponent_on board
		board.winning_combinations.each do |name, coordinate_set|
		# 	if (coordinates.count {|coordinate| board.grid[coordinate[0]][coordinate[1]] == "X"} == 2) && (line.include? "")
		# 		remaining_coordinate = coordinates.index("")
		# 		remaining_coordinate = "O"
		# 	end
		# end

			# coordinate_set.each do |coordinates|
			# 	if (coordinates.count {|coordinate| board.grid[coordinate[0]][coordinate[1]] == "X"} == 2) && 
			if (coordinate_set.count {|coordinate| board.grid[coordinate[0]][coordinate[1]] == "X"} == 2) && coordinate_set.count {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""} == 1
				remaining_coordinate = coordinate_set.select {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""}
				# puts remaining_coordinate.flatten.inspect
				puts remaining_coordinate.flatten[1]
				target board, (remaining_coordinate.flatten[0] + 1), (remaining_coordinate.flatten[1] + 1)
			end
		end
	end







end