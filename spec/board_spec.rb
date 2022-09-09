# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:test_board) { Board.new(false) }

  describe '.initialize' do
    context 'when creating a new board' do
      it 'creates an Array to store board state' do
        expect(test_board.state).to be_a_kind_of(Array)
      end

      it 'initializes 16 pawns' do
        result = test_board.state.count do |position|
            position.is_a?(Pawn)
        end
        expect(result).to eq(16)
      end

      it 'creates a black rook in the top left position' do
        potential_rook = test_board.state[56]
        result = potential_rook.color == :black && potential_rook.is_a?(Rook)
        expect(result).to be(true)
      end

      it 'creates a white bishop in correct bottom left positon' do
        potential_bishop = test_board.state[2]
        result = potential_bishop.color == :white && potential_bishop.is_a?(Bishop)
        expect(result).to be(true)
      end
    end
  end

  describe '.translate_coord' do
    it 'translates [8, 8] correctly' do
      expect(test_board.translate_coord([7, 7])).to eq(63)
    end

    it 'translates [0, 0] correctly' do
      expect(test_board.translate_coord([0, 0])).to eq(0)
    end

    it 'translates [5, 4] correctly' do
      expect(test_board.translate_coord([5, 4])).to eq(37)
    end
  end

  describe '.translate_position' do
    it 'translates 37 correctly' do
      expect(test_board.translate_position(37)).to eq([5, 4])
    end

    it 'translates 0 correctly' do
      expect(test_board.translate_position(0)).to eq([0, 0])
    end

    it 'translates 37 correctly' do
      expect(test_board.translate_position(63)).to eq([7, 7])
    end
  end

  describe '.place_peice'
end