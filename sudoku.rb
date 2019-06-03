class Alga
	SIZE_SUDOKU = 4
	attr_accessor(:oxygen, :content)	


	def initialize
		@content = fill_content
		@oxygen = evaluate_oxygen
	end

	def fill_content
		filled_array = []

		SIZE_SUDOKU.times { |i| filled_array.push(4.times.map { rand(1..4) }) }		

		return filled_array
	end

	def refill_content(line)

	end

	def evaluate_oxygen
		oxygen_produced = 0
		squares = generate_squares(@content)
		
		p @content
		p squares

		@content.each { |line| evaluate_line(line) ? oxygen_produced += 8.3 : 0 }
		@content.transpose.each { |column| evaluate_column(column) ? oxygen_produced += 8.3 : 0 }
		

		return oxygen_produced
	end

	def generate_squares(content)
		squares = []
				


		for i in (0..content.size-1).step(content.size/2)
			square_1 = (content[i][0..content.size/2-1] << content[i+1][0..content.size/2-1]).flatten
			square_2 = (content[i][content.size/2..content.size/2+1] << content[i+1][content.size/2..content.size/2+1]).flatten

			squares << square_1
			squares << square_2
		end
		
		return squares
	end

	def evaluate_line(line)
		return line.uniq.size.eql?(SIZE_SUDOKU)
	end

	def evaluate_column(column)
		return column.uniq.size.eql?(SIZE_SUDOKU)
	end

	def evaluate_square(square)
		return square.uniq.size.eql?(SIZE_SUDOKU)
	end
end

algas = Array.new(1){Alga.new}
