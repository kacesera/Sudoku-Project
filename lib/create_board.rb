require_relative 'tile'


class Create_Board

    def self.from_file(file)
        lines = File.readlines(file).map(&:chomp)
        tiles = []

        lines.each do |row|
            digits = row.split("")
            digits.each do |num|
                tiles << Tile.new(num.to_i)
            end
        end
        self.create_grid(tiles)
    end

    def self.create_grid(tiles)
        tiles = tiles
        array = Array.new(9) {Array.new(9)}

        array.each_with_index do |row, row_idx|
            row.each_index do |col|
                break if tiles.empty?
                array[row_idx][col] = tiles.shift
            end
        end
        
        array
    end
end