module GridHelpers

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


end