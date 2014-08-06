require 'board'

describe Board do 
	
	let(:board) {Board.new}

	it 'displays a 3x3 array' do 
		expect(board.grid).to be_kind_of Array
		expect(board.grid.length).to eq 3
		expect(board.grid.first.length).to eq 3
	end

	it 'displays an X when hit by the player' do
		

	end




end