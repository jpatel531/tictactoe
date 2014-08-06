require 'board'
require 'player'

describe Player do 

	let(:player) {Player.new}
	let(:board) {Board.new}

	it 'is initialized with an X as an identifier' do
		expect(player.marker).to eq 'X'
	end

	it 'can target a board cell' do
		player.target(board, 1, 1)
		expect(board.grid[0][0]).to eq 'X'
	end

	it 'cannot cannot target a cell if outside of board' do 
		expect(STDOUT).to receive(:puts).with 'Out of range bro'
		player.target(board, 9, 9)
	end

	it 'cannot target a cell if it already has been targeted' do 
		board.grid[0][0] = "O"
		expect(STDOUT).to receive(:puts).with 'Already hit bro'
		player.target board, 1, 1
	end




end