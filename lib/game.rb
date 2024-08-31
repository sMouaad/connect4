# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game class containing gameplay logic
class Game
  def initialize
    @current_player = 0
    @next_row = Array.new(Board::BOARD_COLUMNS, Board::BOARD_ROWS - 1)
    @board = Board.new
    @player_one = Player.new(0)
    @player_two = Player.new(1)
  end

  def start
    loop do
      @board.print_board
      user_choice = play
      until @next_row[user_choice] >= 0
        puts 'Column full... try again.'
        user_choice = play
      end
      @board.data[@next_row[user_choice]][user_choice] = @current_player
      @next_row[user_choice] -= 1
      @current_player = (@current_player + 1) % 2
    end
  end

  private

  def play
    (first_player? ? @player_one.play : @player_two.play)
  end

  def first_player?
    @current_player.zero?
  end
end

Game.new.start
