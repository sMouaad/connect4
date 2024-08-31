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
      column = play
      until @next_row[column] >= 0
        puts 'Column full... try again.'
        column = play
      end
      @board.data[@next_row[column]][column] = @current_player
      if check_win?(@next_row[column], column)
        @board.print_board
        puts "Player #{@current_player + 1} wins!"
        break
      end
      @next_row[column] -= 1
      @current_player = (@current_player + 1) % 2
    end
  end

  private

  def check_win?(row, column)
    check_horizontal?(row, column) || check_vertical?(row, column) || check_diagonal?(row, column)
  end

  def check_horizontal?(row, column)
    count_peg_horizontal(row, column, 1) + count_peg_horizontal(row, column, -1) >= 3
  end

  def check_vertical?(row, column)
    count_peg_vertical(row, column, 1) + count_peg_vertical(row, column, -1) >= 3
  end

  def check_diagonal?(row, column)
    return true if count_peg_diagonal(row, column, 1) + count_peg_diagonal(row, column, -1) >= 3

    count_peg_diagonal_inverted(row, column, 1) + count_peg_diagonal_inverted(row, column, -1) >= 3
  end

  ## count methods count how many pegs are in a row
  def count_peg_horizontal(row, column, direction)
    count_peg = 0
    offset = 1
    while correct_column_index?(column + (offset * direction)) && @board.data[row][column + (offset * direction)] == @current_player
      count_peg += 1
      offset += 1
    end
    count_peg
  end

  def count_peg_vertical(row, column, direction)
    count_peg = 0
    offset = 1
    while correct_row_index?(row + (offset * direction)) && @board.data[row + (offset * direction)][column] == @current_player
      count_peg += 1
      offset += 1
    end
    count_peg
  end

  def count_peg_diagonal(row, column, direction)
    count_peg = 0
    offset = 1
    while correct_row_index?(row + (offset * direction)) && correct_column_index?(column + (offset * direction)) && @board.data[row + (offset * direction)][column + (offset * direction)] == @current_player
      count_peg += 1
      offset += 1
    end
    count_peg
  end

  def count_peg_diagonal_inverted(row, column, direction)
    count_peg = 0
    offset = 1
    while correct_row_index?(row + (offset * direction)) && correct_column_index?(column - (offset * direction)) && @board.data[row + (offset * direction)][column - (offset * direction)] == @current_player
      count_peg += 1
      offset += 1
    end
    count_peg
  end

  def correct_row_index?(index)
    index.between?(0, Board::BOARD_ROWS - 1)
  end

  def correct_column_index?(index)
    index.between?(0, Board::BOARD_COLUMNS - 1)
  end

  def play
    (first_player? ? @player_one.play : @player_two.play)
  end

  def first_player?
    @current_player.zero?
  end
end

Game.new.start
