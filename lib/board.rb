require 'colorize'
require 'byebug'
require_relative 'tile'
require_relative 'create_board'

class Board
    attr_reader :board, :grids, :rendered

    def initialize(grid)
        @board = Create_Board.from_file(grid)
    end

    def render
        puts "~*~*~ #{"S U D O K U".bold} ~*~*~"
        puts

        cols = (1..9).to_a
        
        puts "    #{cols.join(" ").colorize(:yellow)}"
        puts

        @board.each_with_index do |row, idx|
            values = row.map do |tile|
                current = tile.show_tile

                if current == tile.value || current == tile.hidden_value
                    current
                else
                    current.to_s.colorize(:cyan)
                end
            end
            puts "#{(idx + 1).to_s.colorize(:yellow)}   #{values.join(" ")}"
        end
        puts

    end

    def row_col_guess(entry)
        string_nums = entry.split(",")
        string_nums.each.reduce([]) do |nums, num|
            nums << (num.to_i - 1)
        end
    end

    def update_board(position, guess)
        row, col = row_col_guess(position)
        @board[row][col].update_tile(guess)
    end

    def has_all_nums?(array)
        array.uniq.sort == [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def solved?
        if complete_rows?
            if complete_cols?
                if complete_3_by_3s?
                    return true
                end
            end
        end
        false
    end

    def complete_rows?
        array = []
        @board.each_with_index do |row, idx|
            row.each_with_index do |tile, idx2|
                if tile.current_value == 0
                    return false
                else
                    array << tile.show_tile.to_i
                end
            end

            if !has_all_nums?(array)
                return false
            end
        end 

        true
    end

    def complete_cols?(col = 0)
        array = []

        @board.each_index do |idx|
            array << @board[idx][col].show_tile.to_i
        end

        if has_all_nums?(array)
            new_col = col + 1
            if new_col != 9
                complete_cols?(new_col)
            else
                return true
            end
        else
            return false
        end
    end

    def complete_3_by_3s?(num = 1)
        mini_grid_array = get_3_by_3(num)

        if has_all_nums?(mini_grid_array)
            new_num = num + 1
            if new_num != 10
                complete_3_by_3s?(new_num)
            else
                return true
            end
        else
            return false
        end
    end

    def get_3_by_3(num)
        array = []

        @board.each_with_index do |row, row_idx|
            row.each_with_index do |tile, ele_idx|
                if row_idx < 3
                    if num == 1 && ele_idx < 3
                        array << tile.show_tile.to_i
                    elsif num == 2 && ele_idx > 2 && ele_idx < 6
                        array << tile.show_tile.to_i
                    elsif num == 3 && ele_idx > 5
                        array << tile.show_tile.to_i
                    end
                end

                if row_idx > 2 && row_idx < 6
                    if num == 4 && ele_idx < 3
                        array << tile.show_tile.to_i
                    elsif num == 5 && ele_idx > 2 && ele_idx < 6
                        array << tile.show_tile.to_i
                    elsif num == 6 && ele_idx > 5
                        array << tile.show_tile.to_i
                    end
                end

                if row_idx > 5
                    if num == 7 && ele_idx < 3
                        array << tile.show_tile.to_i
                    elsif num == 8 && ele_idx > 2 && ele_idx < 6
                        array << tile.show_tile.to_i
                    elsif num == 9 && ele_idx > 5
                        array << tile.show_tile.to_i
                    end
                end
            end
        end

        array
    end

end

