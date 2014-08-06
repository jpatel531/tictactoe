require 'computer'

describe Computer do 

	let(:computer) { Computer.new }

	it 'is a player' do
		expect(computer).to be_a Player
	end

	it 'is is identified by a O' do
		expect(computer.marker).to eq 'O'
	end

	xit 'if not threatened will look to place consecutive markers' do 

	end

end