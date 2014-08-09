require_relative 'player'
require_relative 'board'

class Computer < Player


	def initialize
		@marker = "O"
	end

	def coordinate_values_on board
		Proc.new {|coordinate| board.grid[coordinate[0]][coordinate[1]]}
	end

	def blank_cell_on board
		Proc.new {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""}
	end

	def make_decision_on board
		(first_go_on? board) ? (initial_move_on board) : ((threatening_on? board) ? (killer_shot_on board) : ((threatened_on? board) ? (block_opponent_on board) : ((has_one_in_a_line_on? board) ? (attack board) : (throw_wildcard_on board))))
	end


	def first_go_on? board
		board.grid.none? {|row| row.include? "O"}
	end

	def has_one_in_a_line_on? board
		board.winning_combinations.any? do |name, coordinate_set|
			potential_row = coordinate_set.map(&coordinate_values_on(board))
			true if (!potential_row.include? 'X') && (potential_row.include? 'O')
		end
		false
	end

	def throw_wildcard_on board
		potential_row = board.grid.find { |row| row.include? "" }
		coordinates = [board.grid.index(potential_row), potential_row.index("")]
		target board, coordinates[0] + 1, coordinates[1] + 1
	end	


	def initial_move_on board
		(free_to_place? board, 2, 2) ? (target board, 2, 2) : (target board, 1, 3)
	end

	def attack board
		board.winning_combinations.find do |name, coordinate_set|
			potential_row = coordinate_set.map(&coordinate_values_on(board))
			if (!potential_row.include? 'X') && (potential_row.include? 'O')
				this_spot = coordinate_set.select(&blank_cell_on(board)).shuffle.flatten
				target board, this_spot[0] + 1, this_spot[1] + 1
			end
		end
	end

	def killer_shot_on board
		fill_remaining_spot_on board, "O"
	end

	def block_opponent_on board
		fill_remaining_spot_on board, "X"
	end

	def threatened_on? board
		threats_on? board, "X"
	end

	def threatening_on? board
		threats_on? board, "O"
	end

	def threats_on? board, neighbouring_mark
		board.winning_combinations.any? do |name, coordinate_set|
			contains_two_in_a_line_and_one_blank coordinate_set, board, neighbouring_mark
		end
	end

	def contains_two_in_a_line_and_one_blank coordinate_set, board, neighbouring_mark
		coordinate_set.map(&coordinate_values_on(board)).permutation.to_a.include? [neighbouring_mark, neighbouring_mark, ""]
	end

	def fill_remaining_spot_on board, neighbouring_mark
		board.winning_combinations.each do |name, coordinate_set|
			if contains_two_in_a_line_and_one_blank coordinate_set, board, neighbouring_mark
				remaining_coordinate = coordinate_set.find(&blank_cell_on(board)).flatten
				target board, (remaining_coordinate[0] + 1), (remaining_coordinate[1] + 1)
			end
		end
	end





end