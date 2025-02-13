require 'debug'

def substring(word, substrings)
  found_subs = []
  substrings.each |str| do
    # turn into an array of chars
    # for each word in substrings, if all of the characters in the str are
    # in the word, add it to found subs
    # ignore punctuation and case
    if word.contains?(str)
      found_subs.append(str)
    end
end
