input = File.read('in.txt').chomp.split("\n")

sum = 0
input.each do |line|
  patterns, digits = line.split(' | ')
  digits = digits.split(' ')
  # The digits 1, 4, 7, 8 all have unique numbers of segments turned on
  # 1 -> 2, 4 -> 4, 7 -> 3, 8 -> 7
  # Filter out any digits where the length is not 2, 3, 4, 7. The length of the resulting array is
  # the number of digits that are 1, 4, 7, or 8
  sum += digits.filter { |digit| [2, 3, 4, 7].include? digit.length }.length
end

puts sum
