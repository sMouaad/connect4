# frozen_string_literal: true

require 'colorize'
require_relative 'clear_screen'

# Class with includes logic for board class such as printing logic
class Board
  include ClearScreen
  attr_accessor :data

  PLAYER_ONE = :yellow
  PLAYER_TWO = :red
  COLORS = [PLAYER_ONE, PLAYER_TWO].freeze
  BOARD_ROWS = 6
  BOARD_COLUMNS = 7
  EMPTY_CELL = '● '.colorize(:grey)
  BACKGROUND_COLOR = :black
  PEG = '● '

  def initialize
    @data = Array.new(BOARD_ROWS) { Array.new(BOARD_COLUMNS) }
  end

  def print_board
    clear_screen
    print_rows
    print_column_numbers
  end

  private

  def print_rows
    @data.each do |row|
      row.each do |element|
        print " #{(element && PEG.colorize(color: COLORS[element],
                                           mode: :bold)) || EMPTY_CELL}".colorize(background: BACKGROUND_COLOR)
      end
      puts
    end
  end

  def print_column_numbers
    1.upto(BOARD_COLUMNS) do |number|
      if number < 10
        print " #{number} "
      else
        print "#{number} "
      end
    end
    puts
  end
end
