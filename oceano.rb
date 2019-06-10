require_relative "alga"

class Oceano
    def initialize(sudoku, populacao)
        @sudoku = sudoku
        @algas = Array.new(populacao) { Alga.new(@sudoku) }
    end

    def run
        @algas.each {|alga| puts "sudoku: #{alga.new_content} oxigen: #{alga.oxygen}"}
    end
end

game = Oceano.new([[1, nil, nil, 3], [1, 2, nil, nil], [3, nil, 2, nil], [3, nil, 2, nil]], 1)
game.run