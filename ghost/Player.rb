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

  # Alerts the player about an invalid guess
  def alert_invalid_guess
    puts "Invalid guess! Try again..."
  end

end