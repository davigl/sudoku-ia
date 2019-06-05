require_relative "alga"

class Sudoku
    def initialize(sudoku, populacao)
        @sudoku = sudoku
        @algas = Array.new(populacao) { Alga.new(@sudoku) }
    end

    def run
        @algas.each {|alga| puts "sudoku: #{alga.content} oxigen: #{alga.oxygen}"}
    end
end

game = Sudoku.new([[0, nil, nil, 3], [1, 2, nil, nil], [3, nil, 2, nil], [3, nil, 2, nil]], 1)
game.run