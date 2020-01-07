class Hangman
  attr_reader :guessed

  def initialize(word)
    @word = word.downcase
    @unique_chars = @word.split('').uniq
    @guessed = []
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
    if @guessed.include?(ch) 
      return false
    else
      @guessed.push(ch)
      return true
    end
  end
    
end
words = File.readlines("5desk.txt")
loop do
  i = rand(words.length)
  word = words[i]  
  break if word.length >= 5 && word.length <= 12
end
INCORRECT_GUESSES = 5
incorrect_guess_left = 5
hangman = Hangman.new(word)
loop do
  puts hangman
  puts "Guessed: #{hangman.guessed}"
  puts "#{incorrect_guess_left} incorrect time(s) left"
  puts "Guess:"
  ch = gets.chomp.downcase
  if hangman.guess(ch)
    if 
    next
  else
    puts "Character already guessed"
