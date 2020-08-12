require_relative 'Player.rb'

class Game
  DICTIONARY = "./dictionary.txt"
  attr_reader :current_player, :previous_player

  # Creates a new Game instance
  def initialize(name_1, name_2)
    @player_1 = Player.new(name_1)
    @player_2 = Player.new(name_2)
    @current_player = @player_1
    @previous_player = @player_2
    @fragment = ""

    # Reads lines from file and removes \n from each element
    lines = File.readlines(DICTIONARY).map(&:chomp)

    # Initializes @dictionary as a hash where every key is a letter of the
    # alphabet and each value an array of words that start with that letter
    @dictionary = Hash.new { |h, k| h[k] = [] }
    lines.each { |word| @dictionary[word[0]] << word }
  end

  # Updates @current_player and @previous_player
  def next_player!
    if @current_player == @player_1
      @current_player = @player_2
      @previous_player = @player_1
    else
      @current_player = @player_1
      @previous_player = @player_2
    end
  end

  # Checks that the given string is a letter of the alphabet and that there
  # are words we can spell after adding it to the fragment
  def valid_play?(str)
    return false if !("a".."z").include?(str)
    new_fragment = @fragment + str
    @dictionary[new_fragment[0]].any? { |word| word[0...new_fragment.length] == new_fragment }
  end

  # Gets a string from the player until a valid play is made; then updates the
  # fragment and checks against the dictionary
  def take_turn(player)
    str = ""
    loop do
      str = player.guess
      valid = valid_play?(str)
      player.alert_invalid_guess if !valid
      break if valid
    end
    @fragment += str
    puts "Current fragment: #{@fragment}"
    @dictionary[@fragment[0]].none? { |word| word == @fragment }
  end

  # Plays a round of the game
  def play_round
    while take_turn(@current_player)
      self.next_player!
    end
    puts "Player #{@current_player.name} loses!"
  end

end