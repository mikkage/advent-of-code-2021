diagnostics = File.read('in.txt').chomp.split("\n")

# Number of characters in each line
str_len = diagnostics.first.strip.length

# Create an array of hashes, one hash for the character position 0..n in each line
# Each hash has a 0 and 1 key, which will store the number of times a 0 or 1 has been in that position in each line
arr = []
str_len.times do
  arr << { 0 => 0, 1 => 0 }
end

# For each line, go through each character in the string. In the corresponding hash for the string position, increment the 0 or 1 key depending on whether the character is 0 or 1
# When complete, each hash will have the number of times 0 and 1 has been in that poistion of the string across every line of data
diagnostics.each do |diagnostic|
  diagnostic.strip.each_char.with_index do |c, index|
    arr[index][c.to_i] += 1
  end
end

gamma = ''
# We can now find gamma. If the number of 1s is greater than 0s, add a 1 to gamma, otherwise add a 0
arr.each do |h|
  gamma << '1' if h[1] > h[0]
  gamma << '0' if h[0] > h[1]
end

# Convert the binary representation string to an integer
gamma = gamma.to_i(2)

# Do an XOR to flip the bits to find epsilon. (1 << 6) -1 is equivalent to 0b111111
epsilon = gamma ^ (1 << str_len) -1
puts "Gamma: #{gamma}"
puts "Epsilon: #{epsilon}"

puts "Result: #{gamma * epsilon}"
