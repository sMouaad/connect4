# frozen_string_literal: true

require_relative '../player'

# Human class to get user input
class Human < Player
  def play
    loop do
      user_input = gets.chomp.to_i
      return user_input - 1 if user_input.between?(1, Board::BOARD_COLUMNS)
    end
  end
end
