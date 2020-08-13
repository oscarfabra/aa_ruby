class AiPlayer
  attr_reader :name

  # Creates a new AiPlayer instance
  def initialize(name)
    @name = name
  end

  # Gets a letter from the AiPlayer
  def get_letter(winning_moves, losing_moves)
    letter = (!winning_moves.empty?)? winning_moves.sample : losing_moves.sample
    puts "\nComputer #{@name} chose letter #{letter}"
    letter
  end
end