# frozen_string_literal: true

# Oxygen module that contains auxiliar methods used by seaweed and ocean
module Presentation
  # Ilustration method.
  def self.presentation
    puts '     *  *          /*._   '
    puts " *  *'*  *'*   .-*'`   `*-.._.-'/"
    puts "*'* *'*   **  < * ))     ,     ( "
    puts "*'*  *'* **    `*-._`._(__.--*`."
    puts " *'*  *' *   "
    puts "  *'* *'**   o"
    puts "  *'* *'**    o"
    puts "   *'*'**   O"
    puts "     **"
    puts '+ -------------------------------------------------- +'
    puts '| Hello, welcome to the algorithm bio-inspired in seaweeds |'
    puts '+ -------------------------------------------------- +'
    puts '+ -------------------------------------------------- +'
    puts '| Seaweed is the common name of a diverse grouping   |'
    puts '| photosynthetic organisms whose life cycle is       |'
    puts '| usually completed in the aquatic environment.      |'
    puts '+ -------------------------------------------------- +'

    puts '+ ----------------------------------------------------- +'
    puts '| It is estimated that about 90 percent of the oxygen present|'
    puts "| in the earth's atmosphere are generated by photosynthesis  |"
    puts '| produced by seaweeds.                                |'
    puts '+ ----------------------------------------------------- +'
    puts 'Insert the initial number of seaweeds at the ocean.'
  end

  # Ilustration method;
  # Parameters: seaweeds:array, sudoku:array.

  def self.menu(seaweeds, sudoku)
    puts '', 'Lets begin?'
    puts "The search space currently contains: #{seaweeds.size} seaweeds"
    puts 'They should solve the following sudoku using their oxygen production', ''
    puts '-----------------------------------------------------------'

    sudoku.each { |line| puts "                 | #{line} |" }

    puts '-----------------------------------------------------------', ''
    puts 'The purpose of this algorithm is to solve a given sudoku'
    puts '', 'RULES'
    puts '', '* Seaweeds which oxygen production is to low are eliminated from the ocean.'
    puts '* Seaweeds which oxygen production is to high will reproduce themselves by binary division.'
    puts '* They can reproduce themselves by fragmentation but the chance is too low', ''

    puts 'Press any key to continue'
    gets
  end

  # Ilustration method;
  # Parameters: resolutions:array, count_generations:integer.

  def self.show_resolution(resolutions, count_generations)
    puts "Number of generations: #{count_generations}", 
         'When a seaweed produces 100% of oxygen means it solves the problem, ok?.', ''

    resolutions.uniq.each { |resolution| puts "sudoku: #{resolution} " }
  end
end