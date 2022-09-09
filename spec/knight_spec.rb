require_relative '../lib/pieces/knight'
require_relative '../lib/board'

describe Knight do
  subject(:test_knight) { Knight.new(:black) }
  
  describe '.possible_moves' do
    
    context 'when on an empty board' do
      let(:test_board) { Array.new(8 * 8) }

      it 'returns correct moves from corner' do
        test_board[0] = test_knight
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([17, 10])
      end

      it 'returns correct moves from middle' do
        test_board[36] = test_knight
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([26, 42, 19, 51, 21, 53, 30, 46])
      end
    end

    context 'when on a new board' do
      let(:test_board) { Board.new(false).state }

      before do
        test_board[57] = test_knight
      end

      it 'returns correct moves' do
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([40, 42])
      end
    end

    context 'when a take is possible' do
      let(:test_board) { Array.new(8 * 8) }
      let(:enemy_knight) { Knight.new(:white)}

      before do
        test_board[0] = test_knight
        test_board[17] = enemy_knight
      end

      it 'returns correct moves' do
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([17, 10])
      end
    end
  end
end