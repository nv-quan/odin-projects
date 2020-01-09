require 'yaml'
require 'set'
class CharacterGuessed < StandardError
  def initialize(msg = "Character already guessed", exception_type="custom")
    @exception_type = exception_type
    super(msg)
  end
end
class InvalidInput < StandardError
  def initialize(msg = "Invalid input", exception_type="custom")
    @exception_type = exception_type
    super(msg)
  end
end
class Hangman
  attr_reader :guessed, :word

  def initialize(words)
    word = nil
    loop do
      i = rand(words.length)
      word = words[i].strip
      break if word.length >= 5 && word.length <= 12
    end
    @word = word.strip.downcase
    @unique_chars = @word.split('').uniq.to_set
    @guessed = Set.new
  end

  def num_incorrect
    (@guessed - @unique_chars).length 
  end

  def to_s
    @word.split('').map do |ch|
      if @guessed.include?(ch)
        "#{ch} "
      else
        "_ "
      end
    end.join
  end

  def guess(ch)
    ch = ch.downcase
    raise CharacterGuessed if @guessed.include?(ch)
    raise InvalidInput unless ch.match(/^[a-z]$/)
    @guessed.add(ch)
    if @unique_chars.include?(ch)
      return true
    else 
      return false
    end
  end

  def finished?
    if (@guessed & @unique_chars) == @unique_chars
      return true
    else
      return false
    end
  end
end
def get_choice(*args, **keyword_args) 
  msg = args[0]
  proc1 = args[1]
  proc2 = args[2]
  loop do
    puts msg
    choice = gets.chomp.match(/^[yYnN]$/)
    if choice[0].downcase == 'y'
      return proc1.call(keyword_args)
    elsif choice[0].downcase == 'n'
      return proc2.call(keyword_args)
    else
      puts "Invalid choice"
    end
  end
end
INCORRECT_GUESSES = 5
load_game = lambda do |keyword_args|
  filename = keyword_args[:filename]
  File.open(filename, "r") do |save_file|
    return YAML::load(save_file.read)
  end
end
new_game = lambda do |keyword_args| 
  words = File.readlines("5desk.txt")
  return Hangman.new(words)
end
save_game = lambda do |keyword_args|
  filename = keyword_args[:filename]
  object = keyword_args[:object]
  File.open(filename, 'w') do |save_file|
    str = YAML::dump(object)
    save_file.puts str
  end
  return 'close program'
end
game_play = lambda do |keyword_args|
  hangman = keyword_args[:object]
  puts hangman
  puts "Guessed: #{hangman.guessed.to_a.to_s}"
  puts "#{INCORRECT_GUESSES - hangman.num_incorrect} incorrect time(s) left"
  puts "Guess:"
  ch = gets.chomp.downcase
  begin
    if hangman.guess(ch)
      puts "Correct."
    else
      puts "Incorrect."
    end
    if hangman.finished? && hangman.num_incorrect <= INCORRECT_GUESSES
      puts "#{hangman.word.upcase}. You win."
      return 'close program'
    elsif hangman.num_incorrect > INCORRECT_GUESSES
      puts "You lose."
      puts "The word is: #{hangman.word.upcase}"
      return 'close program'
    end
  rescue StandardError => e
    puts e.message
  end
end
filename = 'hangmansave.yaml'
hangman = get_choice("Do you want to load saved game? (y/n)", load_game, new_game, filename: filename)   
loop do 
  break if get_choice("Do you want to save the game? (y/n)", save_game, game_play, filename: filename, object: hangman) == 'close program'
end
