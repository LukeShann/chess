# -*- encoding : utf-8 -*-
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
          pawn_count = column.reduce(0) do |sum, position|
            sum += 1 if position.is_a?(Pawn)
            sum
          end
          pawn_count == 2
        end

        expect(result).to eq(true)
      end

      it 'creates a black rook in the top left position' do
        rook = test_board.board[0][7]
        result = rook.color == :black && rook.is_a?(Rook)
        expect(result).to be(true)
      end

      it 'creates a white bishop in correct bottom left positon' do
        bishop = test_board.board[2][0]
        result = bishop.color == :white && bishop.is_a?(Bishop)
        expect(result).to be(true)
      end
    end
  end

end


end
