require_relative 'Player.rb'

class Game
  DICTIONARY = "./dictionary.txt"

  # Creates a new Game instance
  def initialize(name_1, name_2)
    @player_1 = Player.new(name_1)
    @player_2 = Player.new(name_2)
    @fragment = ""

    # Reads lines from file and removes \n from each element
    lines = File.readlines(DICTIONARY).map(&:chomp)

    # Initializes @dictionary as a hash with keys as word lengths and each 
    # value an array of words of the key's length
    @dictionary = Hash.new { |h, k| h[k] = [] }
    lines.each { |word| @dictionary[word.length] << word }
  end

end