require 'colorize'
require_relative 'board'
require "byebug"

class Game

    def initialize(grid)
        @board = Board.new(grid)
    end

    def won?
        if @board.solved?
            system("clear")
            @board.render
            sleep(1)
        end
    end

    def position_valid?(pos)
        letters = ("a".."z").to_a
        punctuation = "./:;'()*&^%$#@!~`-_><|"

        if !pos.include?(",")
            return false
        end

        letters.each do |char| 
            if pos.include?(char) || pos.include?(char.upcase)
                return false
            end
        end

        punctuation.split("").each do |sym|
            if pos.include?(sym)
                return false 
            end
        end

        return true
    end


    def play_game
        system("clear")
        numbers = ("1".."9").to_a
        @board.render
        puts "Enter a position to guess a number (format: row, column):"
        position = gets.chomp

        puts "Enter a number for this position:"
        guess = gets.chomp

        if !position_valid?(position)
            puts
            puts "#{"Invalid position!".colorize(:red).bold}"
            puts "Please re-enter a position (format: row, column):"
            position = gets.chomp
        end

        if !numbers.include?(guess)
            puts
            puts "#{"Invalid guess!".colorize(:red).bold} Please guess a number between 1 and 9:"
            guess = gets.chomp
        end

        @board.update_board(position, guess)
    end
end