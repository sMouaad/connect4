# frozen_string_literal: true

# Class with includes logic for board class such as printing logic
class Board
  COLORS = %i[yellow red].freeze
  BOARD_ROWS = 6
  BOARD_COLUMNS = 7
  EMPTY_CELL = ' '
  attr_accessor :board_data

  def initialize
    @board_data = Array.new(BOARD_ROWS) { Array.new(BOARD_COLUMNS, EMPTY_CELL) }
  end

  def print_board
    print_top_line
    print_rows
    print_column_numbers
  end

  private

  def print_rows
    @board_data.each do |row|
      print '|'
      row.each { |element| print " #{element} |" }
      puts
      print_bottom_line
      puts
    end
  end

  def print_column_numbers
    1.upto(BOARD_COLUMNS) do |number|
      if number < 10
        print "  #{number} "
      else
        print " #{number} "
      end
    end
    puts
  end

  def print_top_line
    puts " #{'_' * ((BOARD_COLUMNS * 4) - 1)}"
  end

  def print_bottom_line
    print "|#{'___|' * BOARD_COLUMNS}"
  end
end

Board.new.print_board
