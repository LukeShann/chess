require_relative '../lib/board'

describe Board do
  subject(:test_board) { Board.new }

  describe '.initialize' do
    context 'when creating a new board' do
      it 'creates an Array to store board state' do
        result = test_board.board.is_a?(Array)

        expect(result).to be(true)
      end

      it 'has two pawns in each column' do
        result = test_board.board.all? do |column|
          2 == column.reduce { |sum, square| sum += 1 if square.is_a?(Pawn) }
        end

        expect(result).to eq(true)
      end
    end
  end

end