# frozen_string_literal: true

require_relative '../player'

# AI Player
class Computer < Player
  def play
    (0...Board::BOARD_COLUMNS).to_a.sample
  end
end
