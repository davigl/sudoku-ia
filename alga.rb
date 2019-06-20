class Alga
	SIZE_SUDOKU = 6
	OXYGEN_ONE_VALUE = 100/((SIZE_SUDOKU ** 2) * 2).to_f
	
	# Métodos de Get (alga.oxygen, alga.content, alga.new_content)
	# Variáveis: oxygen:float; :content:array; new_content:array

	attr_accessor(:oxygen, :content, :new_content, :already_cloned)	

	# Construtor do Objeto Alga.
	#
	# Parâmetros: sudoku:array
	# Atributos: content:array ; new_content; oxygen:float

	def initialize(sudoku)
		@content = Marshal.load(Marshal.dump(sudoku))
		@new_content = search_nutrients(sudoku)
		@new_content = ocean_localization(@new_content)
		@oxygen = evaluate_oxygen
		@already_cloned = false
	end

	# Método que recebe um sudoku pré-preenchido e termina de preenchê-lo
	# com valores randomicos (1 até o tamanho do sudoku).
	# 
	# Contexto: As algas buscam por nutrientes no oceano utilizando fotossíntese 
	# e produzindo oxigênio, para isso elas se movimentam (movimento próprio: amebóide) ou 
	# (movimento não próprio: movimentação por ação do ambiente) pelo oceano.
	#
	# Parâmetros: sudoku:array
	# Retorno: filled_array:array

	def search_nutrients(sudoku)
		filled_array = sudoku

		SIZE_SUDOKU.times do |i|
			for j in 0..SIZE_SUDOKU-1
				if filled_array[i][j].nil? 
					filled_array[i][j] = rand(1..SIZE_SUDOKU)
				end
			end
		end	

		return filled_array
	end

	# Método que trata a alga, permancendo somente os valores corretos na matriz.
	# 
	# Contexto: As algas após busca de nutrientes, necessitam se localizar no espaço de busca (Oceano)
	# , algas que se concentram perto da solução estão próximas a localizações de alta geração de nutrientes.
	#
	# Parâmetros: old_content:array

	def ocean_localization(old_content)
		old_content.each_with_index.map do |line, i| 
			line.each_with_index do |v, j| 
				cannot_remove_line = []
				if line.count(v) > 1 and v != nil

					if @content[i].include? v
						cannot_remove_line.push(@content[i].index(v).to_s)
					end

					worst_of_line(old_content, cannot_remove_line, line, v).each { |k, v| line[k.to_s.to_i] = nil }
				end
			end
		end

		new_sudoku = []

		old_content.transpose.each_with_index.map do |column, i|
			column.each_with_index do |v, j| 
				if column.count(v) > 1 and v != nil
					cannot_remove_column = nil

					if @content.transpose[i].include? v
						cannot_remove_column = @content.transpose[i].index(v)
					end

					worst_of_column(column, cannot_remove_column, v).each { |v| column[v.to_i] = nil }
				end
			end

			new_sudoku.push(column)
		end

		new_sudoku = new_sudoku.transpose
		treat_squares(new_sudoku)

		return new_sudoku
	end


	# Método para realizar divisão binária, a reprodução assexuada das algas.
	#
	# Contexto: As algas se reproduzem de duas formas, os seres unicelulares com divisão binária
	# e os seres multicelulares por fragmentação do talo, como é comum nas algas filamentosas. 
	#
	# Retorno child:Alga

	def binary_division
		self.already_cloned = true

		child = Marshal.load(Marshal.dump(self))

		return child
	end

	# Método para avaliar a produção de oxigênio da Alga.
	# 
	# Contexto: As algas possuem uma taxa de produção de oxigênio, essa taxa é obtida quando
	# a alga se encontra em pontos próximos a solução do sudoku, as algas que produzem baixas taxas
	# de oxigênio são eliminadas do espaço de busca.
	#
	# Retorno: oxygen_produced:float

	def evaluate_oxygen
		oxygen_produced = 0
		
		@new_content.each { |line| oxygen_produced += evaluate_line(line) }
		@new_content.transpose.each { |column| oxygen_produced += evaluate_column(column) }
		
		return oxygen_produced
	end

	# Método auxiliar que retorna os piores indices para serem removidos em caso de valores clonados em uma linha.
	# 
	# Parâmetros: content:array; line:array; value:string
	# Retorno: worst_indexes:hash

	def worst_of_line(content, cannot_remove_line, line, value)
		temp = content.transpose
		worst_indexes = {}
		line_count = line.count(value) - 1
		random = [true, false].sample

		temp.each_with_index { |column, i| worst_indexes[i.to_s.to_sym] = column.count(value) if line[i].eql? value }

		if cannot_remove_line.any?
			worst_indexes.delete(cannot_remove_line.first.to_sym)
		end

		random ? worst_indexes.sort_by {|k, v| v}.reverse.first(line_count).to_h : worst_indexes.sort_by {|k, v| v}.first(line_count).to_h
	end

	# Método auxiliar que retorna os piores indices para serem removidos em caso de valores clonados em uma coluna.
	# 
	# Parâmetros: column:array; cannot_remove_column:integer; value:integer
	# Retorno: worst_indexes:array

	def worst_of_column(column, cannot_remove_column, value)
		worst_indexes = []
		column_count = column.count(value) - 1
		column.each_with_index { |v, i| worst_indexes.push(i.to_s) if v.eql? value}
		random = [true, false].sample

		unless cannot_remove_column.nil?
			worst_indexes.delete_at(cannot_remove_column)
		end	

		random ? worst_indexes.first(column_count) : worst_indexes.last(column_count)
	end
	
	# Método auxiliar que trata os quadrados do sudoku.
	# 
	# Parâmetros: content:array
	# Retorno: content:array

	def treat_squares(content)
		size = content.size/2

		for i in (0..content.size-1).step(size)
			content[i].first(size).each.map { |v| content[i].count(v) > (SIZE_SUDOKU/2) - 1 and v != nil ? nil : v } 
			content[i+1].first(size).each.map { |v| content[i+1].count(v) > (SIZE_SUDOKU/2) - 1 and  v != nil ? nil : v } 
			content[i].last(size).each.map { |v| content[i].count(v) > (SIZE_SUDOKU/2) - 1 and v != nil ? nil : v } 
			content[i+1].last(size).each.map { |v| content[i+1].count(v) > (SIZE_SUDOKU/2) - 1 and v != nil ? nil : v } 
		end
	end

	# Método auxiliar que retorna os quadrantes da matriz.
	#
	# Parâmetros: content:array
	# Retorno: squares:array

	def generate_squares(content)
		squares = []
		size = content.size/2

		for i in (0..content.size-1).step(size)
			square_1 = content[i].first(size) << content[i+1].first(size)
			square_2 = content[i].last(size) << content[i+1].last(size)

			squares << square_1.flatten << square_2.flatten
		end
		
		return squares
	end

	# Método auxiliar que avalia a produção de oxigênio de uma linha.
	#
	# Parâmetros: line:array
	# Retorno: line_oxygen_produced:float 

	def evaluate_line(line)
		line_oxygen_produced = line.compact.uniq.size * OXYGEN_ONE_VALUE

		return line_oxygen_produced
	end

	# Método auxiliar que avalia a produção de oxigênio de uma coluna.
	#
	# Parâmetros: column:array
	# Retorno: column_oxygen_produced:float 

	def evaluate_column(column)
		column_oxygen_produced = column.compact.uniq.size * OXYGEN_ONE_VALUE

		return column_oxygen_produced
	end

	# Método que atualiza os valores da alga.

	def set_content
		@new_content = search_nutrients(@new_content)
		@new_content = ocean_localization(@new_content)
		@oxygen = evaluate_oxygen
	end
	
	# Método para verificar igualdade entre objetos Alga.
	# 
	# Contexto: Um par de algas são iguais se possuem o mesmo DNA, portanto devem possuir o mesmo conteúdo (sudoku)
	# 
	# Retorno: boolean

	def equal(other)
		self.new_content == other.new_content
	end

	# Método que retorna a média de oxigênio produzido.

	def media_oxygen
		return OXYGEN_ONE_VALUE * ((SIZE_SUDOKU ** 2) * 2) / 2.50
	end
end
