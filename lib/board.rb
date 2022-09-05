# frozen_string_literal: true

require_relative 'peice'

class Board
  attr_accessor :board
  
  def initialize
    @board = create_board 
  end

  private

  def create_board
    board = []
    ticker = true

    8.times do
      column = []
      8.times do
        column.push({color: ticker ? 'white' : 'black', peice: nil})
        ticker = !ticker
      end

      board.push(column)
      ticker = !ticker
    end
  end

  def fill_board
    @board.map!
  end
end
