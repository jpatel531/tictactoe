module GridScouters

	def coordinate_values
		Proc.new {|coordinate| board.grid[coordinate[0]][coordinate[1]]}
	end

	def blank_cell
		Proc.new {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""}
	end

	def threats_with? neighbouring_mark
		board.winning_combinations.any? do |name, coordinate_set|
			contains_two_in_a_line_and_one_blank coordinate_set, neighbouring_mark
		end
	end

	def contains_two_in_a_line_and_one_blank coordinate_set, neighbouring_mark
		coordinate_set.map(&coordinate_values).permutation.to_a.include? [neighbouring_mark, neighbouring_mark, ""]
	end

	def single_computer_mark(action)
		Proc.new do |name, coordinate_set|
			potential_row = coordinate_set.map(&coordinate_values)
			if (!potential_row.include? 'X') && (potential_row.include? 'O')
				true if action == :find
				this_spot = coordinate_set.select(&blank_cell).shuffle.flatten
				target this_spot[0] + 1, this_spot[1] + 1
			end
		end
	end


end