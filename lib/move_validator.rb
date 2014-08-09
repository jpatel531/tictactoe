module MoveValidator

	def valid_move? board, row, column
		within_bounds?(row, column) && free_to_place?(board, row, column)
	end

	def within_bounds? row, column
		(row > 3 || column > 3) ? out_of_range : true
	end

	def out_of_range
		puts 'Out of range bro' 
		false
	end

	def free_to_place? board, row, column
		(board.grid[row - 1][column - 1] != "") ? already_hit : true
	end

	def already_hit
		puts 'Already hit bro'
		false
	end

	def check input
		exit if input == "exit"
		get_input if invalid? input
	end

	def invalid? string
		(/^\d, \d$/ =~ string).nil?
	end

end