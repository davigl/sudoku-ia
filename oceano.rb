require_relative "alga"

class Oceano

	# Método construtor do oceano.
	# 
	# Parâmetros: sudoku:array, populacao:integer

    def initialize(sudoku, populacao)
        @algas = create_population(sudoku, populacao)
        @sudoku = sudoku
        @count_geracao = 0
    end

    # Método para criar a população no espaço de busca (Oceano)
    #
    # Parâmetros: sudoku:array, populacao:integer
    # Retorno: algas:array

    def create_population(sudoku, populacao)
    	algas = []

    	populacao.times {|i| clone_sudoku = Marshal.load(Marshal.dump(sudoku)); algas.push(Alga.new(clone_sudoku))}

    	return algas
    end

    # Método para contextualizar a aplicação

    def self.presentation
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

    # Método para o menu da aplicação

    def menu
    	puts "","Vamos começar?"
    	puts "O espaço de busca contém atualmente: #{@algas.size} algas"
    	puts "Elas devem solucionar o seguinte sudoku a partir da produção de oxigênio.", ""
    	puts "-----------------------------------------------------------"
    	
    	@sudoku.each {|line| puts "                 | #{line} |" }
    	
    	puts "-----------------------------------------------------------", ""
    	puts "O intuito do algoritmo é resolver o sudoku demonstrando as várias possiveis maneiras."
    	puts "","REGRAS"
    	puts "","* As algas que produzem baixas taxas de oxigênio serão eliminadas do oceano."
    	puts "* As algas que produzem altas taxas de oxigênio irão se reproduzir por divisão binária."
    	puts "* As algas no oceano também podem se reproduzir por fragmentação, e terá chances de 1 porcento de ocorrer a cada geração.", ""

    	puts "Pressione a tecla enter para continuar"
    	gets
    end

    # Método para executar a aplicação.
    # A condição de parada é quando a geração atual permanecer igual a geração anterior.

    def run
    	media_oxygen = @algas.sample.media_oxygen
    	resolutions = []

        while true
    		@current_generation = Marshal.load(Marshal.dump(@algas))
    		@algas.push(fragmentation(selection(@algas))) if rand > 0.95
    		
			@algas.each do |alga| 
				alga.set_content if alga.oxygen < 100
				
				@algas.delete(alga) if alga.oxygen < media_oxygen
					
				if alga.oxygen.between?(75, 99) and not alga.already_cloned
					@algas.push(alga.binary_division)
				end

				if alga.oxygen.between?(99.99, 100.0)
					resolutions.push(alga.new_content)

					@algas.delete(alga)
				end
			end

			if @algas.size.eql? @current_generation.size
		    	break if resolutions.size >= 1
			end

			@count_geracao += 1
			
			if @algas.size != @current_generation
				puts "Número de algas no ambiente de busca: #{@algas.size}"
			end
        end

        puts "Número de gerações: #{@count_geracao}", "As Algas a seguir possuem produção de oxigênio em 100%, portanto resolvem o problema do sudoku.", ""
        
        resolutions.uniq.each { |resolution| puts "sudoku: #{resolution} "}
	end

	# Método que busca um par de algas no oceano.

	def selection(algas)
		algas_selection = algas.sample(2)
		algas_selection.each {|alga| algas.delete(alga)}

		return algas_selection
	end

	# Método gera um filho a partir do sudoku de duas algas.
	#
	# Contexto: Utiliza de um par de algas para reprodução sexuada em fragmentação, 
	# nessa reprodução há compartilhamento de DNA entre ambos seres.
	#
	# Parâmetros: selection:array
	# Retorno: object:Alga

	def fragmentation(selection)
		sudoku = selection.first.new_content.each_with_index.map {|line, i| line.each_with_index.map {|value, j| value.nil? ? selection.last.new_content[i][j] : value} }

		return Alga.new(sudoku)
	end
end

Oceano.presentation

puts "Digite o número de algas da população inicial."
population = gets.chomp.to_i

game = Oceano.new([[3, nil, 4, nil], [nil, 1, nil, 2], [nil, 4, nil, 3], [2, nil, 1, nil]], population)
game.menu
game.run