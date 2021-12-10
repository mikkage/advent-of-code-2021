input = File.read('in.txt').chomp.split("\n")

# Use an array of each of the opening symbols since we only need to know which ones open
openers = ['(', '{', '[', '<']

# Map each closing symbol to its opening symbol
closers = {
  ')' => '(',
  '}' => '{',
  ']' => '[',
  '>' => '<'
}

# Map each closing symbol to its numerical value
scores = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

incorrect_syntax_sums = []

input.each do |line|
  # Keep track of each opening symbol as we parse through the input
  openings = []

  line.split('').each do |char|
    # If the current character is an opening character, add it to the array of openings
    # and go to the next iteration
    openings << char if openers.include?(char)
    next unless closers[char]

    # If it's a closing character, first check to see if it matches the last opening charachter
    if openings.last == closers[char]
      # If it does match, we can remove the last opening character as this one has closed it
      openings.pop
    else
      # If it does not match, we have found a corrupted input and need to add the score for the
      # incorrect closing symbol and then stop iteration
      incorrect_syntax_sums << scores[char]
      break
    end
  end
end

puts incorrect_syntax_sums.sum
