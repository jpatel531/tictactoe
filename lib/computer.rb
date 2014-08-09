require_relative 'player'
require_relative 'board'
require_relative 'grid_helpers'

class Computer < Player

	include GridHelpers

	attr_accessor :board

	def initialize
		@marker = "O"
	end

	def make_decision
		first_go? ? initial_move : threatening? ? killer_shot : threatened? ? block_opponent : has_one_in_a_line? ? advance : throw_wildcard
	end


	def first_go?
		board.grid.none? {|row| row.include? "O"}
	end

	def has_one_in_a_line?
		board.winning_combinations.any? do |name, coordinate_set|
			potential_row = coordinate_set.map(&coordinate_values)
			true if (!potential_row.include? 'X') && (potential_row.include? 'O')
		end
		false
	end

	def throw_wildcard
		potential_row = board.grid.find { |row| row.include? "" }
		coordinates = [board.grid.index(potential_row), potential_row.index("")]
		target coordinates[0] + 1, coordinates[1] + 1
	end	


	def initial_move
		(free_to_place? 2, 2) ? (target 2, 2) : (target 1, 3)
	end

	def advance
		board.winning_combinations.find do |name, coordinate_set|
			potential_row = coordinate_set.map(&coordinate_values)
			if (!potential_row.include? 'X') && (potential_row.include? 'O')
				this_spot = coordinate_set.select(&blank_cell).shuffle.flatten
				target this_spot[0] + 1, this_spot[1] + 1
			end
		end
	end

	def killer_shot
		fill_remaining_spot "O"
	end

	def block_opponent
		fill_remaining_spot "X"
	end

	def threatened?
		threats_with? "X"
	end

	def threatening?
		threats_with? "O"
	end


	def fill_remaining_spot neighbouring_mark
		board.winning_combinations.each do |name, coordinate_set|
			if contains_two_in_a_line_and_one_blank coordinate_set, neighbouring_mark
				remaining_coordinate = coordinate_set.find(&blank_cell).flatten
				target (remaining_coordinate[0] + 1), (remaining_coordinate[1] + 1)
			end
		end
	end





end