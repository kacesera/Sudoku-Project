require_relative "game"
require "byebug"

game_num = rand(1..3)
sudoku = Game.new("./puzzles/sudoku#{game_num}.txt")

sudoku.play_game until sudoku.won?

system("clear")
puts 
puts "Congratulations! You successfully completed the puzzle!"
sleep(3)
system("clear")