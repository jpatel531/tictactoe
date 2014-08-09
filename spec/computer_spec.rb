require 'computer'

describe Computer do 

	let(:computer) { Computer.new }
	let(:player) {Player.new}
	let(:board) {Board.new}
	before do 
		computer.board = board 
		player.board = board
	end

	it 'can do what a player can do' do
		expect(computer).to be_a Player
	end

	it 'is is identified by a O' do
		expect(computer.marker).to eq 'O'
	end

	it 'for his first go will go for the middle tile if not taken' do 
		computer.make_decision
		expect(board.grid[1][1]).to eq "O"
	end

	it 'will go for tiles in a row if not threatened' do 
		computer.target 1, 1
		computer.make_decision
	end

	it 'will block off an opponent who has an advantage' do
		player.target 1,1
		computer.target 3, 3
		player.target 1,2
		computer.make_decision
		expect(board.grid[0][2]).to eq "O"
	end

	it 'will block them off even if the tiles are not consecutive' do 
		player.target 1,1
		computer.target 3, 3
		player.target 1,3
		computer.make_decision
		expect(board.grid[0][1]).to eq "O"

	end


	it 'if threatened, but is his go, will go for the killer' do 
		computer.target 1, 1
		computer.target 1, 2
		computer.make_decision
		expect(board.grid[0][2]).to eq "O"
	end

	it 'if not threatened nor threatening nor first go, will throw a wildcard' do 
		board.grid = [["X", "X", "O"], ["O", "O", "X"], ["X", "", ""]]
		computer.make_decision
		# puts board.grid[2]
		expect(board.grid[2]).to include "O"
	end


end