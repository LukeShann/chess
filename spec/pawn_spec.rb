require_relative '../lib/pieces/pawn'
require_relative '../lib/board'

describe Pawn do
  describe '.initialize' do
    context 'when creating a black pawn' do
      subject(:test_pawn) { Pawn.new(:black, [1, 6]) }

      it 'sets correct move directions' do
        directions = test_pawn.instance_variable_get(:@move_directions)
        expect(directions).to eq([[0, -1], [0, -2]])
      end

      it 'sets correct take directions' do
        directions = test_pawn.instance_variable_get(:@take_directions)
        expect(directions).to eq([[-1, -1], [1, -1]])
      end
    end
  end
end