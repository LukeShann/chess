# frozen_string_literal: true

local_directory = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(local_directory)
Dir['lib/peices/*.rb'].each { |file| require file }

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    fill_board
    @selected = nil
    @high_lighted = nil
  end

  #private

  def fill_board
    place_pawns
    place_peices(Rook, [[0, 0], [7, 0], [0, 7], [7, 7]])
    place_peices(Knight, [[1, 0], [6, 0], [1, 7], [6, 7]])
    place_peices(Bishop, [[2, 0], [5, 0], [2, 7], [5, 7]])
    place_peices(Queen, [[3, 7], [3, 0]])
    place_peices(King, [[4, 7], [4, 0]])
  end

  def place_pawns
    8.times do |i|
      @board[i][1] = Pawn.new(:white, [i, 1])
      @board[i][6] = Pawn.new(:black, [i, 6])
    end
  end

  def place_peices(peice_class, coords)
    coords.each do |coord|
      if coord.last == 0
        @board[coord.first][coord.last] = peice_class.new(:white, coord)
      else
        @board[coord.first][coord.last] = peice_class.new(:black, coord)
      end
    end
  end

  def valid_selection?(coords, current_player)
    peice = board[coords.first][coords.last]
    return false if peice.nil?
    peice.color == current_player && peice.can_move?
  end
end
