module UI

	def display_welcome_message
		puts "Welcome to TicTacToe. Try to beat me... if you dare"
	end

	def get_input 
		puts "Enter where you wish to place your tile by row and column number, e.g. '1, 1'. Type 'exit' to exit "
		input = STDIN.gets.chomp
		check input
		coordinates = input.split(", ").map(&:to_i)
		valid_move?(coordinates[0], coordinates[1]) ? human.target(coordinates[0], coordinates[1]) : get_input
	end

	def winner_message
		puts (winner == human) ? "Well done, human. You have fought valiantly" : (winner == computer) ? "Power to the computer! Huzzah!" : "Draw! The endless struggle twixt Man and Machine continues"
	end

	def clear_screen_and_show_grid
		puts "\e[H\e[2J"
		puts board.grid.map(&:inspect)
	end

	def play_again?
		puts "Do you wish to play again? 'y' for restart and 'n' for exit"
		wish = STDIN.gets.chomp
		(wish == 'y') ? start_new_game : (wish == 'n') ? exit : play_again?
	end

end