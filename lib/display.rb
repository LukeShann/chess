# frozen_string_literal: true

require 'colorize'

module Display

  def display_board
    color_ticker = true
    puts '   A  B  C  D  E  F  G  H'
    7.downto(0) do |y|
      print "#{y + 1} "
      8.times do |x|
        print_square(x, y, color_ticker)
        color_ticker = !color_ticker
      end
      print " #{y + 1}\n"
      color_ticker = !color_ticker
    end
    puts '   A  B  C  D  E  F  G  H'
  end

  def print_square(x, y, color_ticker)
    board_position = translate_coord([x, y])
    content = @board.state[board_position]
    to_print = content.nil? ? '   ' : " #{content.ascii} "

    if @board.high_lighted.include?(board_position)
      print to_print.black.on_green
    elsif @board.selected_position == board_position
      print to_print.black.on_cyan
    else
      print color_ticker ? to_print.black.on_white : to_print.black.on_yellow
    end
  end

  def message(message, reset)
    message_que.push(message)
    @que = @que.last(3)
    @que.shift if @que.first == @que.last
    @que = [message] if reset 
    display
  end

  def message_que
    @que ||= []
  end

  def display
    system "clear"
    display_board

    @que.each do |message|
      puts messages[message].blue
    end
  end

  def messages
    {
      welcome: "Welcome to Chess Supreme!",
      turn_instructions: "#{@current_player}'s turn".capitalize,
      input_instructions: "Choose coordinates",
      invalid_input: "Input should be a letter & number (e.g. 4C)",
      no_peice_to_select: "No peice there",
      peice_cannot_move: "Peice has no possible moves",
      choose_friendly_peice: "That's not your peice",
      make_move: "Where would you like to move to?",
      cannot_move_there: "Can't move there"
    }
  end
end
