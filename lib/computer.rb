require_relative 'player'
require_relative 'board'

class Computer < Player


	def initialize
		@marker = "O"
	end

	def make_decision_on board
		if first_go_on? board
			initial_move_on board
		elsif threatening_on? board
			killer_shot_on board
		elsif threatened_on? board
			block_opponent_on board
		elsif has_one_in_a_line_on? board
			attack board
		else
			throw_wildcard_on board
			# attack board
		end
	end

	def first_go_on? board
		board.grid.none? {|row| row.include? "O"}
	end

	def has_one_in_a_line_on? board
		board.winning_combinations.find do |name, coordinate_set|
			potential_row = coordinate_set.map {|coordinate| board.grid[coordinate[0]][coordinate[1]]}
			if (!potential_row.include? 'X') && (potential_row.include? 'O')
				return true
			end
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
			potential_row = coordinate_set.map {|coordinate| board.grid[coordinate[0]][coordinate[1]]}
			if (!potential_row.include? 'X') && (potential_row.include? 'O')
				this_spot = coordinate_set.select {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""}.shuffle.flatten
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
			coordinate_set.map {|coordinate| board.grid[coordinate[0]][coordinate[1]]}.permutation.to_a.include? [neighbouring_mark, neighbouring_mark, ""]
		end
	end


	def fill_remaining_spot_on board, neighbouring_mark
		board.winning_combinations.each do |name, coordinate_set|
			if coordinate_set.map {|coordinate| board.grid[coordinate[0]][coordinate[1]]}.permutation.to_a.include? [neighbouring_mark, neighbouring_mark, ""]
				remaining_coordinate = coordinate_set.find {|coordinate| board.grid[coordinate[0]][coordinate[1]] == ""}.flatten
				target board, (remaining_coordinate[0] + 1), (remaining_coordinate[1] + 1)
			end
		end
	end





end