def caesar_cipher str, num
  subs = lambda do |ch, num|
    is_cap = ch == ch.upcase
    a = is_cap ? 'A' : 'a'
    num_of_char = 'z'.ord - 'a'.ord + 1
    ((ch.ord - a.ord + num) % num_of_char + a.ord).chr
  end
  str.gsub(/[a-zA-Z]/) { |x| subs.call(x, num) }
end 
