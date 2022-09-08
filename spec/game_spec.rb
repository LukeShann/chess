# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  subject(:test_game) { Game.new }

  describe '.input_valid?' do
    it 'accepts a letter and number' do
      expect(test_game.input_valid?('4C')).to be(true)
    end

    it 'accepts with letter first' do
      expect(test_game.input_valid?('C4')).to be(true)
    end
    
    it 'accepts lower case letters' do
      expect(test_game.input_valid?('c4')).to be(true)
    end

    it 'rejects two numbers' do
      expect(test_game.input_valid?('55')).to be(false)
    end

    it 'rejects two letters' do
      expect(test_game.input_valid?('AD')).to be(false)
    end

    it 'rejects input over 2 characters' do
      expect(test_game.input_valid?('A4B')).to be(false)
    end

    it 'rejects letters out of range' do
      expect(test_game.input_valid?('6Y')).to be(false)
    end

    it 'rejects numbers out of range' do
      expect(test_game.input_valid?('A9')).to be(false)
    end
  end

  describe '.translate_input' do
    it 'translates A5 to 0, 4' do
      expect(test_game.translate_input('A5')).to eq([0, 4])
    end

    it 'translates 3c to 2, 2' do
      expect(test_game.translate_input('3c')).to eq([2, 2])
    end
  end


end