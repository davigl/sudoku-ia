# frozen_string_literal: true

require_relative 'oxygen'
require_relative 'worst'

# TreatArray module that contains auxiliar methods used to treat sudoku array
module TreatArray
  include Oxygen
  include WorstArray

  # Uses: treat the lines in a sudoku, remaining the best unique values;
  # Parameters: old_content:array.

  def treat_line(old_content)
    old_content.each_with_index.map do |line, index|
      line.each.map do |value|
        next unless value && line.count(value) > 1

        array = @content[index]
        cannot_remove_line = array.include?(value) ? array.index(value).to_s.to_sym : nil
        worst_indexes = worst_of_line(old_content, cannot_remove_line, line, value)
        worst_indexes.each_key { |key| line[key.to_s.to_i] = nil }
      end
    end
  end

  # Uses: treat the coluns in a sudoku, remaining the best unique values;
  # Parameter: content:array.

  def treat_column(old_content, new_sudoku)
    old_content.transpose.each_with_index.map do |column, index|
      column.each do |value|
        next unless value && column.count(value) > 1

        transposed_array = @content.transpose[index]
        cannot_remove_column = transposed_array.include?(value) ? 
                               transposed_array.index(value) : nil
        worst_indexes = worst_of_column(column, cannot_remove_column, value)
        worst_indexes.each { |key| column[key.to_i] = nil }
      end

      new_sudoku.push(column)
    end
  end

  # Uses: treat the squares of a sudoku, remaining the best unique values;
  # Parameter: content:array.

  def treat_squares(content)
    size = content.size / 2

    (0..content.size - 1).step(size).each.map do |index|
      first_part, second_part = content[index], content[index + 1]

      treat_squares_aux(first_part.first(size))
      treat_squares_aux(second_part.first(size))
      treat_squares_aux(first_part.last(size))
      treat_squares_aux(second_part.last(size))
    end
  end

  private

  # Uses: get a square from a sudoku and treat them.

  def treat_squares_aux(part)
    size_required = (SIZE_SUDOKU/2) - 1

    part.each.map { |value| value && part.count(value) > size_required ? nil : value } 
  end
end
