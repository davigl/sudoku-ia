# frozen_string_literal: true

# This module contains seaweed reproduction methods.
module Reproduction
  # Select two random seaweeds, remove them from the search space to generate
  # a new specie from both;
  # Parameters: seaweeds:array;
  # Return: seaweeds_selection:array.

  def selection(seaweeds)
    seaweeds_selection = seaweeds.sample(2)
    seaweeds_selection.each { |seaweed| seaweeds.delete(seaweed) }

    seaweeds_selection
  end

  # Reproduce a new better specie through fragmentation process;
  # Parameters: seaweeds:array;
  # Return: seaweed:Seaweed.

  def fragmentation(selection)
    sudoku = selection.first.new_content.each_with_index.map do |line, line_index|
      line.each_with_index.map do |value, column_index|
        !value ? selection.last.new_content[line_index][column_index] : value
      end
    end

    Seaweed.new(sudoku)
  end
end
