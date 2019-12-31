# frozen_string_literal: true

require_relative 'seaweed'
require_relative 'lib/oxygen'
require_relative 'lib/presentation'
require_relative 'lib/reproduction'

# Author: Davi Guimarães Leite
# Ocean class represents the search space where seaweeds are located.
class Ocean
  include Oxygen
  include Reproduction

  attr_reader :sudoku, :seaweeds

  # Ocean constructor
  #
  # Parameters: sudoku:array, initial_population:integer

  def initialize(sudoku, initial_population)
    @seaweeds = create_population(sudoku, initial_population)
    @sudoku = sudoku
  end

  # Uses: generate seaweed population at a search space;
  #
  # Parameters: sudoku:array, population:integer
  # Return: seaweeds:array

  def create_population(sudoku, population)
    seaweeds = []

    population.times do
      clone_sudoku = Marshal.load(Marshal.dump(sudoku))
      seaweeds.push(Seaweed.new(clone_sudoku))
    end

    seaweeds
  end

  # Uses: main run method, it stops when found a resolution.

  def run
    resolutions = []
    count_generation = 0

    loop do
      current_generation = Marshal.load(Marshal.dump(@seaweeds)).size
      @seaweeds.push(fragmentation(selection(@seaweeds))) if rand > 0.95

      modifying_generation(@seaweeds, resolutions)

      unless @seaweeds.size.eql? current_generation
        puts "Seaweeds at the search space: #{@seaweeds.size}"
      end

      break if resolutions.size >= 1

      count_generation += 1
    end

    Presentation.show_resolution(resolutions, count_generation)
  end

  # Uses: it modifies the actual generation;
  # Parameters: seaweeds:array, resolutions:array;
  # Return: resolutions:array.

  def modifying_generation(seaweeds, resolutions)
    media_oxygen = media_oxygen()

    seaweeds.each do |seaweed|
      oxygen = seaweed.oxygen

      seaweed.set_content if oxygen < 100
      seaweeds.delete(seaweed) if oxygen < media_oxygen && seaweeds.size > 2
      seaweeds.push(seaweed.binary_division) if oxygen.between?(75, 99) && !seaweed.already_cloned
      (resolutions.push(seaweed.new_content); break) if oxygen.between?(99, 100.0)
    end
  end
end

# Starts the game.

Presentation.presentation
population = gets.chomp.to_i
game = Ocean.new([[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil],
                  [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil],
                  [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]], population)
Presentation.menu(game.seaweeds, game.sudoku)
game.run
