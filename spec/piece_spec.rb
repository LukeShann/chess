require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/knight'
require_relative '../lib/board'

describe Piece do
  subject(:test_knight) { Knight.new(:white) }
  let(:test_board) { Board.new(false).state }

  before { test_board[0] = test_knight }
  
  describe '.can_move?' do
    context 'when open to move' do
      it 'returns true' do
        expect(test_knight.can_move?(test_board)).to be(true)
      end
    end

    context 'when there are no possible moves' do
      before do
        test_board[17] = Knight.new(:white)
        test_board[10] = Knight.new(:white)
      end

      it 'returns false' do
        expect(test_knight.can_move?(test_board)).to be(false)
      end
    end
  end
end