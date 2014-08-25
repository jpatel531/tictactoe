require_relative 'computer'
require_relative 'rules'
require_relative 'grid_scouters'
require_relative 'ui'

class Game

	attr_reader :human, :computer, :board
	attr_accessor :turn

	include Rules
	include GridScouters
	include UI

	def initialize
		@human = Player.new
		@computer = Computer.new
		@board = Board.new
		@turn = @human
		computer.board = @board
		human.board = @board
	end

	def switch_turn
		@turn = (turn == human) ? computer : human
	end
		
	def move
		(turn == human) ? (get_input) : (computer.make_decision)
	end

	def winner
		board.winning_combinations.each do |name, coordinate_set|
			line = coordinate_set.map(&coordinate_values)
			if (line == ["X", "X", "X"]) || (line == ["O", "O", "O"])
				return (line.first == "X") ? human : computer	
			end
		end
		nil
	end

	def end_of_game?
		!winner.nil? || (board.grid.none? { |row| row.include? ""})
	end

	def start_new_game
		initialize
		play
	end

	def each_player_takes_turns
		clear_screen_and_show_grid
		move
		switch_turn
	end

	def play
		display_welcome_message
		until end_of_game?
			each_player_takes_turns
		end
		clear_screen_and_show_grid
		winner_message
		play_again?
	end

end
