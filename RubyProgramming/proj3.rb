def substrings(str, dictionary)
  result = {}
  dictionary.each do |word|
    (str.length - word.length + 1).times do |i|
      word.length.times do |j|
        if str[i + j].downcase != word[j].downcase
          break
        elsif j == word.length - 1
          if result[word].nil?
            result[word] = 1
          else
            result[word] += 1
          end
        end
      end
    end
  end
  result
end
