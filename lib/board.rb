class Board

	attr_accessor :grid

	def initialize
		@grid = Array.new(3) { Array.new(3) {""} }
	end

	def winning_combinations
		{
			row_one: [[0,0], [1,0], [2,0]],
			row_two: [[0,1], [1,1], [2,1]],
			row_three: [[0,2], [1,2], [2,2]],
			column_one: [[0,0], [0,1], [0,2]],
			column_two: [[1,0], [1,1], [1,2]],
			column_three: [[2,0], [2,1], [2,2]],
			diagonal_one: [[0,0], [1,1], [2,2]],
			diagonal_two: [[2,0], [1,1], [0,2]]
		}

	end



end

