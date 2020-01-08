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
words = File.readlines("5desk.txt")
INCORRECT_GUESSES = 5
hangman = Hangman.new(words)
loop do
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
      break
    elsif hangman.num_incorrect > INCORRECT_GUESSES
      puts "You lose."
      puts "The word is: #{hangman.word.upcase}"
      break
    end
  rescue StandardError => e
    puts e.message
  end
end
