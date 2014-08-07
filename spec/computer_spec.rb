require 'computer'

describe Computer do 

	let(:computer) { Computer.new }
	let(:player) {Player.new}
	let(:board) {Board.new}

	it 'can do what a player can do' do
		expect(computer).to be_a Player
	end

	it 'is is identified by a O' do
		expect(computer.marker).to eq 'O'
	end

	it 'will block off an opponent who has an advantage' do
		player.target board, 1,1
		player.target board, 1,2
		computer.block_opponent_on board
		expect(board.grid[0][2]).to eq "O"
	end

	it 'if not threatened, will go for consecutive tiles' do 


	end

	it 'if threatened, but is his go, will go for the killer' do 


	end

	it 'should decide between blocking an opponent and pursuing an advantage' do 

	end

end