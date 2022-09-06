# frozen_string_literal: true

require 'colorize'

module Display

  def display_board
    color_ticker = true
    puts '   A  B  C  D  E  F  G  H'
    7.downto(0) do |y|
      print "#{8 - y} "
      8.times do |x|
        position = @board.board[x][y]
        to_print = position.nil? ? '   ' : " #{position.ascii} "
        print color_ticker ? to_print.black.on_white : to_print.black.on_yellow
        color_ticker = !color_ticker
      end
      print "\n"
      color_ticker = !color_ticker
    end
  end

  def message(message)
    message_que.push(message)

    @que = @que.last(3)

    display
  end

  def display
    system "clear"
    display_board

    message_que.each do |message|
      puts messages[message].blue
    end
  end

  def message_que
    @que ||= []
  end

  def messages
    {
      
    }
  end
end
