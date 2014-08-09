require 'game'

describe Game do 

	let(:game) { Game.new }
	let(:human) { game.human }
	let(:computer) {game.computer}
	let(:board)  {game.board}

	it 'the human player goes first' do
		expect(game.turn).to eq human
	end



	it 'alerts a human winner' do 
		human.target 1, 1
		human.target 1, 2
		human.target 1, 3
		expect(game.winner).to eq human
	end

	it 'alerts a computer winner' do 
		3.times { computer.make_decision}
		expect(game.winner).to eq computer
	end


end