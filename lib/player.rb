require_relative 'move_validator'

class Player

	include MoveValidator

	attr_reader :marker

	def initialize
		@marker = "X"
	end

	def target board, row, column
		board.grid[row - 1][column - 1] = marker if	valid_move? board, row, column
	end

end