require_relative '../lib/pieces/knight'
require_relative '../lib/board'

describe Knight do
  subject(:test_knight) { Knight.new(:black, [0, 0]) }
  
  describe '.possible_moves' do
    
    context 'when on an empty board' do
      let(:test_board) { Array.new(8) {Array.new(8)} }

      it 'returns correct moves from corner' do
        test_board[0][0] = test_knight
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([[1, 2], [2, 1]])
      end

      it 'returns correct moves from middle' do
        test_board[4][4] = test_knight
        test_knight.instance_variable_set(:@coords, [4, 4])
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([[2, 3], [2, 5], [3, 2], [3, 6], [5, 2], [5, 6], [6, 3], [6, 5]])
      end
    end

    context 'when on a new board' do
      let(:test_board) { Board.new.board }

      before do
        test_board[1][7] = test_knight
        test_knight.instance_variable_set(:@coords, [1, 7])
      end

      it 'returns correct moves' do
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([[0, 5], [2, 5]])
      end
    end

    context 'when a take is possible' do
      let(:test_board) { Array.new(8) {Array.new(8)} }
      let(:enemy_knight) { Knight.new(:white, [1, 2])}

      before do
        test_board[0][0] = test_knight
        test_board[1][2] = enemy_knight
      end

      it 'returns correct moves' do
        result = test_knight.possible_moves(test_board)
        expect(result).to eq([[1, 2], [2, 1]])
      end
    end
  end
end