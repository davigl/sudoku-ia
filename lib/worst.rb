# frozen_string_literal: true

# WorstArray module that contains auxiliar methods which gives worst sudoku indexes
module WorstArray
  # Get the worst indexes to be removed in a line;
  # Parameters: content:array, cannot_remove_line:symbol, line:array, value_target:string;
  # Return: worst_indexes:hash.

  def worst_of_line(content, cannot_remove_line, line, value_target)
    temp = content.transpose
    worst_indexes = {}
    line_count = line.count(value_target) - 1

    temp.each_with_index { |column, index| worst_indexes[index.to_s.to_sym] = column.count(value_target) if line[index].eql? value_target }
    cannot_remove_line && worst_indexes.delete(cannot_remove_line)

    worst_indexes.sort_by { |_k, v| v }.last(line_count).to_h
  end

  # Get the worst indexes to be removed in a column;
  # Parameters: column:array; cannot_remove_column:integer; value_target:string;
  # Return: worst_indexes:array

  def worst_of_column(column, cannot_remove_column, value_target)
    worst_indexes = []
    column_count = column.count(value_target) - 1
    column.each_with_index { |value, index| worst_indexes.push(index.to_s) if value.eql? value_target }
    random = [true, false].sample

    cannot_remove_column && worst_indexes.delete_at(cannot_remove_column)
    random ? worst_indexes.first(column_count) : worst_indexes.last(column_count)
  end
end
