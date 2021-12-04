diagnostics = File.read('in.txt').chomp.split("\n")
# Number of characters in each line
str_len = diagnostics.first.strip.length

# Keep two lists which start off with all diagnostic values
# Each list will be filtered down as things are processed
o2_ratings = diagnostics
co2_ratings = diagnostics

# Each of the o2 and co2 ratings will be filtered by a patter of how the string must start
# These strings are built up as things are processed and used to filter the possible values
o2_rating_pattern = ''
co2_rating_pattern = ''

(0..str_len-1).to_a.each_with_index do |pos|
  # Make sure there is more than one rating left in the list before trying to filter down any more
  if o2_ratings.length > 1
    # Count the number of 0s and 1s in the position in each data point
    h = { 0 => 0, 1 => 0 }
    o2_ratings.each do |rating|
      h[rating[pos].to_i] += 1
    end

    # Using the number of 0s and 1s counted, add to the filter
    # Add a 1 if the number of 1s is gte the number of 0s(1s more common)
    # Add a 0 if the number of 1s is less than the number of 0s(0s more common)
    o2_rating_pattern << '1' if h[1] >= h[0]
    o2_rating_pattern << '0' if h[1] < h[0]

    # Filter down the list based on the updated filer by removing anything that doesn't start with the filter
    o2_ratings = o2_ratings.select { |rating| rating.start_with?(o2_rating_pattern) }
  end

  # Make sure there is more than one rating left in the list before trying to filter down any more
  if co2_ratings.length > 1
    # Count the number of 0s and 1s in the position in each data point
    h = { 0 => 0, 1 => 0 }
    co2_ratings.each do |rating|
      h[rating[pos].to_i] += 1
    end

    # Using the number of 0s and 1s counted, add to the filter
    # Add a 1 if the number of 0s is greater than the number of 1s(1s less common)
    # Add a 0 if the number of 0s is lte the number of 1s(0s less common)
    co2_rating_pattern << '1' if h[1] < h[0]
    co2_rating_pattern << '0' if h[1] >= h[0]

    # Filter down the list based on the updated filer by removing anything that doesn't start with the filter
    co2_ratings = co2_ratings.select { |rating| rating.start_with?(co2_rating_pattern) }
  end
end

# Since the filter should have us with a unique result, we can just get the first element from each array and convert to an int
o2_rating = o2_ratings.first.to_i(2)
co2_rating = co2_ratings.first.to_i(2)

puts "O2 Rating: #{o2_rating}"
puts "CO2 Rating: #{co2_rating}"
puts "Result: #{o2_rating * co2_rating}"
