class Player
  attr_reader :name

  # Creates a new Player instance
  def initialize(name)
    @name = name
  end

  # Gets a guess from the player
  def guess
    print "\nPlayer #{@name}, guess a letter: "
    str = gets.chomp.downcase
  end
end