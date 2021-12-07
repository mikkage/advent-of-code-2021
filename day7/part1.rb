positions = File.read('in.txt').chomp.split(',').map(&:to_i)

# Store the sums of units to move for each position in a hash where the position
# is mapped to the sum of all the moves needed for all to reach that position
totals = {}

# Check every position between the closest and farthest
(positions.min..positions.max).each do |position|
  # For each unique original position, create a new array which holds the distances
  # by subtracting the current position from every position in the original array then summing it all together
  # Then map the position to the sum of distances for all others to get to that position
  totals[position] = positions.map { |orig_pos| (position - orig_pos).abs }.sum
end

# Finally, to get the result we just get all the values from the map, sort them, and get the lowest value
puts "Result: #{totals.values.sort.first}"
