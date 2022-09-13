# frozen_string_literal: true

module Memory
  def load_game
    data = File.read(save_path)
    hash = JSON.parse(data, symbolize_names: true)
    load_board = JSON.parse(hash[:board], symbolize_names: true)
    
    @board.load_in_state(load_board)
    @current_player_color = hash[:turn].to_sym
    @in_check = hash[:in_check]
  end

  def save_path
    __FILE__.gsub('lib/memory.rb', 'save/saved_game.txt')
  end

  def save_game
    data = {
      board: @board.to_json,
      turn: @current_player_color,
      in_check: @in_check
    }
    json_data = data.to_json
    File.open(save_path, 'w') do |file| 
      file.write(json_data)
    end
  end
end