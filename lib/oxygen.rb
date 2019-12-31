# frozen_string_literal: true

# Oxygen module that contains auxiliar methods used by seaweed and ocean
module Oxygen
  # Constants

  SIZE_SUDOKU = 6
  OXYGEN_ONE_VALUE = 100 / ((SIZE_SUDOKU**2) * 2).to_f

  # Uses: calculate a media value for oxygen production;
  # Return: media_oxygen:float

  def media_oxygen
    OXYGEN_ONE_VALUE * ((SIZE_SUDOKU**2) * 2) / 2.50
  end

  # Uses: evaluate the amount of oxygen produced by the amount of unique values
  # in column contained in a seaweed;
  # Parameter: line:array;
  # Return: line_oxygen_produced:float.

  def evaluate_line(line)
    line.compact.uniq.size * OXYGEN_ONE_VALUE
  end

  # Uses: evaluate the amount of oxygen produced by the amount of unique values
  # in column contained in a seaweed;
  # Parameter: column:array;
  # Return: column_oxygen_produced:float.

  def evaluate_column(column)
    column.compact.uniq.size * OXYGEN_ONE_VALUE
  end

  # Uses: evaluate oxygen production of seaweed;
  # Parameter: content:array;
  # Context: seaweeds have an oxygen production rate, this rate is obtained when
  # the seaweed is located near the sudoku solution, the seaweed that produces
  # low rates of oxygen are eliminated from the search space;
  # Return: oxygen_produced:float.

  def evaluate_oxygen(content)
    oxygen_produced = 0
    content.each { |line| oxygen_produced += evaluate_line(line) }
    content.transpose.each { |column| oxygen_produced += evaluate_column(column) }
    oxygen_produced
  end
end
