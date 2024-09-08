# frozen_string_literal: true

require_relative 'board'
require_relative 'players/computer'
require_relative 'players/human'

# Game class containing gameplay logic
class Game
  def initialize(ai, player)
    @current_player = 0
    @next_row = Array.new(Board::BOARD_COLUMNS, Board::BOARD_ROWS - 1)
    @board = Board.new
    if ai == 1
      @player_one = Human.new(Board::PLAYER_ONE)
      @player_two = Human.new(Board::PLAYER_TWO)
    else
      @player_one = (player == 1 ? Human.new(Board::PLAYER_ONE) : Computer.new(Board::PLAYER_ONE))
      @player_two = (player == 2 ? Human.new(Board::PLAYER_ONE) : Computer.new(Board::PLAYER_ONE))
    end
  end

  def start
    loop do
      @board.print_board
      column = play
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
    count_peg_vertical(row, column) >= 3
  end

  def check_diagonal?(row, column)
    return true if count_peg_diagonal(row, column, 1) + count_peg_diagonal(row, column, -1) >= 3

    count_peg_diagonal_inverted(row, column, 1) + count_peg_diagonal_inverted(row, column, -1) >= 3
  end

  ## count methods count how many pegs are in a row, vertically, horizontally, diagonally
  def count_peg_horizontal(row, column, direction)
    count_peg = 0
    offset = 1
    while correct_column_index?(column + (offset * direction)) && @board.data[row][column + (offset * direction)] == @current_player
      count_peg += 1
      offset += 1
    end
    count_peg
  end

  def count_peg_vertical(row, column)
    count_peg = 0
    offset = 1
    while correct_row_index?(row + offset) && @board.data[row + offset][column] == @current_player
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
    user_choice = (first_player? ? @player_one.play : @player_two.play)
    until @next_row[user_choice] >= 0
      puts "Column #{user_choice + 1} full... try again."
      user_choice = (first_player? ? @player_one.play : @player_two.play)
    end
    user_choice
  end

  def first_player?
    @current_player.zero?
  end
end
