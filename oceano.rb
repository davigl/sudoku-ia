require_relative "alga"

class Oceano
    def initialize(sudoku, populacao)
        @algas = create_population(sudoku, populacao)
        @sudoku = sudoku
        @count_geracao = 0
        @conjugation_rate = 10
    end

    def create_population(sudoku, populacao)
    	algas = []

    	populacao.times {|i| clone_sudoku = Marshal.load(Marshal.dump(sudoku)); algas.push(Alga.new(clone_sudoku))}

    	return algas
    end

    def presentation
    	puts "     *  *          /*._   "
		puts " *  *'*  *'*   .-*'`   `*-.._.-'/"
		puts "*'* *'*   **  < * ))     ,     ( "
		puts "*'*  *'* **    `*-._`._(__.--*`."
		puts " *'*  *' *   "
		puts "  *'* *'**   o"
		puts "  *'* *'**    o"
		puts "   *'*'**   O"
		puts "     **"
    	puts "+ -------------------------------------------------- +"
    	puts "| Olá, bem vindo ao algoritmo bio-inspirado nas Algas |"
    	puts "+ -------------------------------------------------- +"
    	puts "+ -------------------------------------------------- +"
    	puts "| Alga é o nome comum de um diversificado agrupamento|" 
    	puts "| polifilético de organismos fotossintéticos cujo    |"
    	puts "| ciclo de vida se completa geralmente em meio aquático. |"
    	puts "+ -------------------------------------------------- +"


    	puts "+ ----------------------------------------------------- +"
    	puts "| Estima-se que cerca de 90 porcento do oxigênio presente|" 
    	puts "| na atmosfera terrestre seja gerado pela fotossíntese   |"
    	puts "| das algas planctônicas.                                |"
    	puts "+ ----------------------------------------------------- +"
    end

    def menu
    	puts "","Vamos começar?"
    	puts "O espaço de busca contém atualmente: #{@algas.size} algas"
    	puts "Elas devem solucionar o seguinte sudoku a partir da produção de oxigênio.", ""
    	puts "","REGRAS"
    	puts "","* As algas que produzem baixas taxas de oxigênio serão eliminadas do oceano."
    	puts "* As algas que produzem altas taxas de oxigênio se reproduzirão por divisão binária."
    	puts "* As algas no oceano também podem se reproduzir por fragmentação.", ""
    	puts "----------------------------------------------"
    	
    	@sudoku.each {|line| puts "          | #{line} |" }
    	
    	puts "----------------------------------------------", ""
    end

    def run
    	presentation
    	menu

        while true
    		@actual_generation = Marshal.load(Marshal.dump(@algas))

    		puts "Número de gerações: #{@count_geracao}"

    		if @algas.size > 1

    		end

			@algas.each do |alga| 
				# puts "sudoku: #{alga.new_content}"
				alga.set_content
				# alga.new_content.any? { |e| e.include?(nil) ? (done = false; alga.set_content) : nil }
				# @algas.push(alga.binary_division) if alga.oxygen >= 90
				# @algas.delete(alga) if alga.oxygen <= 60
				
				if alga.oxygen < 50
					@algas.delete(alga)
				end

				if alga.oxygen.between?(85, 99) and not alga.already_cloned
					@algas.push(binary_division(alga))
				end
			end

			if @algas.size.eql? @actual_generation.size
		    	break if @actual_generation.each_with_index.all? {|alga, i| alga.equal (@algas[i])}
			end
        end

		@count_geracao += 1
        @algas.each {|alga| puts "sudoku: #{alga.new_content} oxigen: #{alga.oxygen}" if alga.oxygen.eql? (100.0)}
	end

	def fragmentation(alga_1, alga_2)
		alga_1.new_content.each_with_index.map {|line, i| line.each_with_index.map {|value, j| value.nil? ? alga2.new_content[i][j] : value} }
	end

	def binary_division(alga)
		alga.already_cloned = true
		child = Marshal.load(Marshal.dump(alga))

		return child
	end
end

game = Oceano.new([[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]], 5)
game.run