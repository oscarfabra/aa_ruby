require_relative 'Player.rb'

class Game
  DICTIONARY = "./dictionary.txt"
  attr_reader :current_player, :previous_player

  # Creates a new Game instance
  def initialize(*args)
    raise "There must be at least two players" if args.length < 2

    # Initializes the players array
    @players = []
    args.each { |name| @players << Player.new(name) }

    # Sets current and previous players and the current fragment
    @current_player = @players.first
    @previous_player = @players.last
    @fragment = ""

    # Reads lines from file and removes \n from each element
    lines = File.readlines(DICTIONARY).map(&:chomp)

    # Initializes @dictionary as a hash where every key is a letter of the
    # alphabet and each value an array of words that start with that letter
    @dictionary = Hash.new { |h, k| h[k] = [] }
    lines.each { |word| @dictionary[word[0]] << word }

    # Hash to keep track of the times a player looses
    @losses = {}
    @players.each { |player| @losses[player] = 0 }
  end

  # Updates @current_player and @previous_player
  def next_player!
    previous_i = @players.index(@current_player)
    @previous_player = @current_player
    current_i = (previous_i + 1) % @players.length
    @current_player = @players[current_i]
    until @losses[@current_player] != 5
      current_i = (current_i + 1) % @players.length
      @current_player = @players[current_i]
    end
  end

  # Checks that the given string is a letter of the alphabet and that there
  # are words we can spell after adding it to the fragment
  def valid_play?(str)
    return false if !("a".."z").include?(str)
    new_fragment = @fragment + str
    @dictionary[new_fragment[0]].any? { |word| word[0...new_fragment.length] == new_fragment }
  end

  # Translates a player's losses into a substring of "GHOST"
  def record(player)
    "GHOST"[0...@losses[player]]
  end

  # Gets a string from the player until a valid play is made; then updates the
  # fragment and checks against the dictionary
  def take_turn(player)
    str = ""
    loop do
      str = player.guess
      valid = valid_play?(str)
      if !valid
        puts "Invalid guess! Try again..."
        puts "Current fragment: #{@fragment}"
      end
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
    @losses[@current_player] += 1
    puts "Player #{@current_player.name} loses!"
    @fragment = ""
    self.next_player!
  end

  # Shows the scoreboard after each round
  def display_standings
    puts "\nStandings:"
    @players.each do |player|
      puts "Player #{player.name} record: #{self.record(player)}"
    end
  end

  # Calls #play_round until only one of the players has less than 5 losses
  def run
    until @losses.values.one? { |losses| losses != 5 }
      self.play_round
      self.display_standings
    end
    winner = @losses.keys.select { |player| @losses[player] != 5 }.first
    puts "\nPlayer #{winner.name} wins the game! =)"
  end
end