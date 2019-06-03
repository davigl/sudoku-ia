class Alga
	SIZE_SUDOKU = 4
	OXYGEN_ONE_VALUE = 100/((SIZE_SUDOKU ** 2) * 3).to_f
	
	attr_accessor(:oxygen, :content, :new_content)	

	def initialize
		@content = fill_content
		@new_content = @content
		@new_content = refill_content(@new_content)
		@oxygen = evaluate_oxygen
	end

	def fill_content
		filled_array = []

		SIZE_SUDOKU.times { |i| filled_array.push(SIZE_SUDOKU.times.map { rand(1..SIZE_SUDOKU) }) }		

		return filled_array
	end

	def refill_content(old_content)
		old_content.each.map { |line| line.each.map { |v| line.count(v) > 1 ? nil : v } }
		old_content.transpose.each.map { |column| column.each.map { |v| column.count(v) > 1 ? nil : v } }
	end

	def evaluate_oxygen
		oxygen_produced = 0
		squares = generate_squares(@new_content)
			
		@new_content.each { |line| oxygen_produced += evaluate_line(line) }
		@new_content.transpose.each { |column| oxygen_produced += evaluate_column(column) }
		squares.each {|square| oxygen_produced += evaluate_square(square) }

		return oxygen_produced
	end

	def generate_squares(content)
		squares = []
		
		for i in (0..content.size-1).step(content.size/2)
			square_1 = (content[i][0..content.size/2-1] << content[i+1][0..content.size/2-1]).flatten
			square_2 = (content[i][content.size/2..content.size/2+1] << content[i+1][content.size/2..content.size/2+1]).flatten

			squares << square_1 << square_2
		end
		
		return squares
	end

	def evaluate_line(line)
		return line.compact.uniq.size * OXYGEN_ONE_VALUE
	end

	def evaluate_column(column)
		return column.compact.uniq.size * OXYGEN_ONE_VALUE
	end

	def evaluate_square(square)
		return square.compact.uniq.size * OXYGEN_ONE_VALUE
	end

	def binary_division
		child = @new_content

		return child
	end
end

algas = Array.new(1){Alga.new}
p algas[0].oxygen