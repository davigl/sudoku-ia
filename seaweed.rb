# frozen_string_literal: true

require_relative 'lib/oxygen'
require_relative 'lib/treat'

# The seaweed class represents a sudoku problem
class Seaweed
  include Oxygen
  include TreatArray

  # Get Methods (seaweed.oxygen, seaweed.content, seaweed.new_content)
  # Variables: oxygen:float; content:array; new_content:array

  attr_accessor(:oxygen, :content, :new_content, :already_cloned)

  # Seaweed constructor;
  # Parameters: sudoku:array;
  # Attributes: content:array, new_content, oxygen:float.

  def initialize(sudoku)
    @content = Marshal.load(Marshal.dump(sudoku))
    @new_content = search_nutrients(sudoku)
    @new_content = ocean_localization(@new_content)
    @oxygen = evaluate_oxygen(@new_content)
    @already_cloned = false
  end

  # Uses: receives a pre-filled sudoku and it finishes to fill with random values;
  # Context: Seaweeds search for nutrients at the ocean using photosynthesis,
  # producing oxygen, so they move by the ocean using (own moviment: ameboid move) or
  # (not own move: environmental movement);
  # Parameters: sudoku:array;
  # Return: sudoku:array;

  def search_nutrients(sudoku)
    SIZE_SUDOKU.times do |line|
      SIZE_SUDOKU.times do |column|
        sudoku[line][column] = rand(1..SIZE_SUDOKU) if sudoku[line][column].nil?
      end
    end

    sudoku
  end

  # Uses: changes seaweed ocean localization;
  # Parameters: old_content:array;
  # Return: new_sudoku:array.

  def ocean_localization(old_content)
    new_sudoku = []

    treat_line(old_content)
    treat_column(old_content, new_sudoku)
    new_sudoku = new_sudoku.transpose
    treat_squares(new_sudoku)

    new_sudoku
  end

  # Uses: reproduction by binary division, commonly occurs in unicellular beings;
  # Return: child:Seaweed.

  def binary_division
    self.already_cloned = true

    Marshal.load(Marshal.dump(self))
  end
  
  # Uses: updates some seaweed values;

  def set_content
    @new_content = search_nutrients(@new_content)
    @new_content = ocean_localization(@new_content)
    @oxygen = evaluate_oxygen(@new_content)
  end
end
