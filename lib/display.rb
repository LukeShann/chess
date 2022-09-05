# frozen_string_literal: true

require 'colorize'

module Display

  def display_board
    color_ticker = true
    7.downto(0) do |y|
      8.times do |x|
        position = @board.board[x][y]
        to_print = position.nil? ? '   ' : " #{position.ascii} "
        print color_ticker ? to_print.on_white : to_print.on_light_magenta
        color_ticker = !color_ticker
      end
      print "\n"
      color_ticker = !color_ticker
    end
  end

end
