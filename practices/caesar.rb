require 'debug'

def caesar_cipher(phrase, amount)
  alphabet = ("a".."z").to_a 
  encoded = Array.new(phrase.length)
  length = alphabet.length
  phrase.split("").each do |letter|
    if !alphabet.include?(letter.downcase)
      encoded.push(letter)
    else
      index = alphabet.find_index(letter.downcase)
      if (index + amount) > length
        shifted_index = index + amount - 26
      else 
        shifted_index = index + amount
      end

      if letter == letter.upcase 
        encoded.push(alphabet[shifted_index].upcase)
      else
        encoded.push(alphabet[shifted_index])
      end
    end
  end
  return encoded.join
end

phrase = gets.chomp
number = gets.chomp.to_i
puts(caesar_cipher(phrase, number))
