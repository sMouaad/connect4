# frozen_string_literal: true

require_relative 'board'
# Class containing user interactions
class Player
  attr_reader :number

  def initialize(player_number)
    @number = player_number
  end

  def play
    loop do
      user_input = gets.chomp.to_i
      return user_input - 1 if user_input.between?(1, Board::BOARD_COLUMNS)
    end
  end
end
