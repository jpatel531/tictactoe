require_relative 'computer'

class Game

	attr_reader :human, :computer, :board
	attr_accessor :turn

	def initialize
		@human = Player.new
		@computer = Computer.new
		@board = Board.new
		@turn ||= @human
	end

	def display_welcome_message
		puts "Welcome to TicTacToe. Try to beat me... if you dare"
	end

	def switch_turn
		@turn = (turn == human) ? computer : human
	end
		
	def move
		(turn == human) ? (get_input) : (computer.make_decision_on board)
	end

	def invalid? string
		(/^\d, \d$/ =~ string).nil?
	end

	def get_input 
		puts "Enter where you wish to place your tile by row and column number, e.g. '1, 1'. Type 'exit' to exit "
		input = STDIN.gets.chomp
		exit if input == "exit"
		get_input if invalid? input
		coordinates = input.split(", ").map(&:to_i)
		human.valid_move?(board, coordinates[0], coordinates[1]) ? human.target(board, coordinates[0], coordinates[1]) : get_input
	end

	def winner
		board.winning_combinations.each do |name, coordinate_set|
			line = coordinate_set.map {|coordinate| board.grid[coordinate[0]][coordinate[1]]}
			if (line == ["X", "X", "X"]) || (line == ["O", "O", "O"])
				return (line.first == "X") ? human : computer	
			end
		end
		nil
	end

	def winner_message
		puts (winner == human) ? "Well done, human. You have fought valiantly" : (winner == computer) ? "Power to the computer! Huzzah!" : "Draw! The endless struggle twixt Man and Machine continues"
	end

	def end_of_game?
		!winner.nil? || (board.grid.none? { |row| row.include? ""})
	end

	def clear_screen_and_show_grid
		puts "\e[H\e[2J"
		puts board.grid.map(&:inspect)
	end

	def play_again?
		puts "Do you wish to play again? 'y' for restart and 'n' for exit"
		wish = STDIN.gets.chomp
		if wish == 'y'
			@board = Board.new
			@turn = human
			play
		elsif wish == 'n'
			exit
		end
	end

	def play
		display_welcome_message
		until end_of_game?
			clear_screen_and_show_grid
			move
			switch_turn
		end
		clear_screen_and_show_grid
		winner_message
		play_again?
	end

end