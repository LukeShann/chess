# frozen_string_literal: true

require 'colorize'

module Display
  def display_board
    color_ticker = true
    puts "   A  B  C  D  E  F  G  H"
    7.downto(0) do |y|
      print "#{y + 1} "
      8.times do |x|
        print_square(x, y, color_ticker)
        color_ticker = !color_ticker
      end
      print " #{y + 1}\n"
      color_ticker = !color_ticker
    end
    puts "   A  B  C  D  E  F  G  H\n\n"
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

  def message(message)
    puts messages[message]
  end

  def refresh_board
    system "clear"
    display_board
  end

  def messages
    {
      welcome: "Welcome to Chess Supreme!".yellow.on_black,
      turn_instructions: "#{@current_player_color.capitalize}'s turn".blue,
      input_instructions: "Choose coordinates".blue,
      invalid_input: "Input should be a letter & number (e.g. 4C)".yellow,
      no_peice_to_select: "No peice there".yellow,
      peice_cannot_move: "Peice has no possible moves".yellow,
      choose_friendly_peice: "That's not your peice".yellow,
      make_move: "Where would you like to move to?".blue,
      save_load_menu: "[ L ] to load a saved game\n[ S ] to save current game & exit".blue,
      game_loaded: "Game loaded successfully".yellow,
      game_saved: "Game saved, see ya!".yellow,
      no_save_file: "No save file found".yellow,
      unselect: "Enter [ X ] to unselect".blue,
      unselected: "Piece unselected".blue,
      cannot_move_there: "Can't move there".yellow,
      in_check: "In check, careful!".blue,
      check_mate: "Checkmate! #{@current_player_color.capitalize} player wins!".green,
      exposing_king: "Can't leave king exposed!".yellow,
    }
  end
end
