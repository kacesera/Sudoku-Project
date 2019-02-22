require 'colorize'

class Tile

    attr_reader :value, :hidden_value, :current_value

    def initialize(value)
        @value = value
        @given = false
        @current_value = value
        @hidden_value = ("*").colorize(:magenta)
    end

    def given?
        if value != 0
            @given = true
            return true
        end
        false
    end

    def update_tile(guess)
        @current_value = guess
    end

    def show_tile
        if given?
            return @value
        elsif @current_value != 0 
            return @current_value
        else
            return @hidden_value
        end
    end

end



