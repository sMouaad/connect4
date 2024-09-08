# frozen_string_literal: true

require_relative 'board'
# Class containing user interactions
class Player
  attr_reader :number

  def initialize(player_number)
    @number = (player_number == Board::PLAYER_ONE ? 0 : 1)
  end

  def play; end
end
