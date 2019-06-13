class Alga

	# Constantes

	SIZE_SUDOKU = 4
	OXYGEN_ONE_VALUE = 100/((SIZE_SUDOKU ** 2) * 3).to_f
	
	# Métodos de Get (alga.oxygen, alga.content, alga.new_content)
	# Variáveis: oxygen:float; :content:array; new_content:array

	attr_accessor(:oxygen, :content, :new_content)	

	# Construtor do Objeto Alga.
	#
	# Parâmetros: sudoku:array
	# Atributos: content:array ; new_content; oxygen:float

	def initialize(sudoku)
		@content = fill_content(sudoku)
		@new_content = @content
		@new_content = refill_content(@new_content)
		@oxygen = evaluate_oxygen
	end

	# Método que recebe um sudoku pré-preenchido e termina de preenchê-lo
	# com valores randomicos (1 até o tamanho do sudoku).
	# 
	# Parâmetros: sudoku:array
	# Retorno: filled_array:array

	def fill_content(sudoku)
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
	# Parâmetros: old_content:array

	def refill_content(old_content)
		old_content.each.map do |line| 
			line.each_with_index { |v, i| line.count(v) > 1 ? worst_of_line(old_content, line, v).each { |k, v| line[k.to_s.to_i] = nil } : v }
		end
	end

	# Método auxiliar que retorna os piores indices para serem removidos em caso de valores clonados em uma linha.
	# 
	# Parâmetros: content:array; line:array; value:string
	# Retorno: worst_indexes:hash

	def worst_of_line(content, line, value)
		temp = content.transpose
		worst_indexes = {}
		line_count = line.count(value) - 1

		temp.each_with_index { |column, i| worst_indexes[i.to_s.to_sym] = column.count(value) if line[i] == value }

		worst_indexes.sort_by {|k, v| v}.reverse.first(line_count).to_h
	end

	# Not implemented yet

	def worst_of_column(content, column); end

	# Método para avaliar a produção de oxigênio da Alga.
	#
	# Retorno: oxygen_produced:float

	def evaluate_oxygen
		oxygen_produced = 0
		squares = generate_squares(@new_content)
		
		@new_content.each { |line| oxygen_produced += evaluate_line(line) }
		@new_content.transpose.each { |column| oxygen_produced += evaluate_column(column) }
		squares.each {|square| oxygen_produced += evaluate_square(square) }

		return oxygen_produced
	end

	# Método auxiliar que retorna os quadrantes da matriz.
	#
	# Parâmetros: content:array
	# Retorno: squares:array

	def generate_squares(content)
		squares = []
		
		for i in (0..content.size-1).step(content.size/2)
			square_1 = (content[i][0..content.size/2-1] << content[i+1][0..content.size/2-1]).flatten
			square_2 = (content[i][content.size/2..content.size/2+1] << content[i+1][content.size/2..content.size/2+1]).flatten

			squares << square_1 << square_2
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

	# Método auxiliar que avalia a produção de oxigênio de um quadrante.
	#
	# Parâmetros: square:array
	# Retorno: square_oxygen_produced:float 

	def evaluate_square(square)
		square_oxygen_produced = square.compact.uniq.size * OXYGEN_ONE_VALUE

		return square_oxygen_produced
	end

	# Not implemented yet.

	def binary_division
		child = @new_content

		return child
	end
end
