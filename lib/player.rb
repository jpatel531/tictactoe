require_relative 'move_validator'

class Player

	include MoveValidator

	attr_reader :marker
	attr_accessor :board

	def initialize
		@marker = "X"
	end

	def target row, column
		board.grid[row - 1][column - 1] = marker if valid_move? row, column
	end

end