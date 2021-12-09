input = File.read('in.txt').chomp.split("\n")

# Store the grid in a hash where the key is an array with two numbers, the x and y coordinates
# and the value is the height at that coordinate
# Set the default to 99 so that if we go out of bounds, it will be greater than any number on the grid
grid = {}
grid.default = 99

# Load the input into the grid
input.each_with_index do |line, y|
  line.split('').each_with_index do |height, x|
    grid[[x,y]] = height.to_i
  end
end

low_points = []
risk_levels = []

# Number of lines in the input is the y value
input.length.times do |y|
  # Number of characters in the line is the x value
  input[0].length.times do |x|
    # For each point, search the four spots above, below, and to each side
    search_coordinates = [
      [x, y+1],
      [x+1, y],
      [x-1, y],
      [x, y-1]
    ]

    # If all of the adjacent coordinates have a higher value, then this coordinate is a low spot.
    # Otherwise it's not a low spot and we can continue to evaluate the next spot
    next unless search_coordinates.all? { |(x1, y1)| grid[[x1, y1]] > grid[[x, y]] }
    low_points << [x, y]
    risk_levels << 1 + grid[[x, y]]
  end
end

puts risk_levels.sum
