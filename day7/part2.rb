positions = File.read('in.txt').chomp.split(',').map(&:to_i)

# Store the sums of units to move for each position in a hash where the position
# is mapped to the sum of all the moves needed for all to reach that position
totals = {}

# Check every position between the closest and farthest
(positions.min..positions.max).each do |position|
  # Same as part 1, but using the different way to calculate the fuel cost
  # Since the cost starts at 1 and increases by one for each unit moved after, it can be represented with this function:
  # f(n) = 1 + 2 + 3 + ... + n  - Note that n is the total distance traveled
  # Which can be simplified to:
  # f(n) = (n * (n + 1)) / 2
  totals[position] = positions.map { |orig_pos| dist = (position - orig_pos).abs; (dist * (dist + 1)) / 2 }.sum
end

# Finally, to get the result we just get all the values from the map, sort them, and get the lowest value
puts "Result: #{totals.values.sort.first}"
