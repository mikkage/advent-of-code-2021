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
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

completion_lines = []

input.each do |line|
  corrupted_line = false
  # Keep track of each opening symbol as we parse through the input
  openings = []

  line.split('').each do |char|
    # If the current character is an opening character, add it to the array of openings
    # and go to the next iteration
    openings << char if openers.include?(char)
    next unless closers[char]

    # If the closing character does not match the last opening one, it's a corrupted line
    # We only need to mark this as corrupted and then break from the loop
    if openings.last != closers[char]
      corrupted_line = true
      break
    end

    # Otherwise it's a valid closing symbol and we can remove the last opening character
    openings.pop
  end

  # If the line is corrupted or all openings have been closed, then we don't have to do anything else
  next if corrupted_line || openings.length == 0

  # Build the string containing the characters to close the rest of the incomplete line
  completion_line = ''
  # Since we need to start from the last opening character, reverse the opening symbols before iterating
  openings.reverse.each do |char|
    # Add the corresponding closing symbol to the string for each opening character
    completion_line << closers.key(char)
  end

  completion_lines << completion_line
end

completion_line_scores = []

completion_lines.each do |line|
  total = 0
  line.split('').each do |char|
    total *= 5
    total += scores[char]
  end
  completion_line_scores << total
end

# There will always be an odd number of incomplete lines, so length / 2 will always give the index of the middle element
puts completion_line_scores.sort[completion_line_scores.length / 2]
