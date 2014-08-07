module MoveValidator

	def valid_move? board, row, column
		within_bounds?(row, column) && free_to_place?(board, row, column)
	end

	def within_bounds? row, column
		if row > 3 || column > 3 
			puts 'Out of range bro' 
			false
		else
			true
		end
	end

	def free_to_place? board, row, column
		if board.grid[row - 1][column - 1] != ""
			puts 'Already hit bro'
			false
		else
			true
		end
	end


end