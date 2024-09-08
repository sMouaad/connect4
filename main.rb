# frozen_string_literal: true

require_relative 'lib/game'
def user_input
  gets.chomp.to_i
end

def choose_player
  puts 'Play as :'
  puts '1. Player 1'
  puts '2. Player 2'

  one_or_two = user_input
  one_or_two = user_input until one_or_two.between?(1, 2)
  one_or_two
end

def choose_player_or_ai
  puts '1. Human vs Human '
  puts '2. Human vs Computer'

  human_or_ai = user_input
  human_or_ai = user_input until human_or_ai.between?(1, 2)
  human_or_ai
end

human_or_ai = choose_player_or_ai

one_or_two = choose_player if human_or_ai == 2

game = Game.new(human_or_ai, one_or_two)

game.start
