# Explores a basin from the given coordinate in the given grid
# Returns an array containing all of the coordinates of nodes that have been visited
def explore_basin(low_point, grid)
  # Search each node above, below, and to each side of the coordinate to check for continuations of the basin
  search_deltas = [
    [0, 1],
    [1, 0],
    [-1, 0],
    [0, -1]
  ]

  # The point given has already been visited
  visited_nodes = [low_point]

  # Search the adjacent points by adding each delta to the current coordinate
  search_deltas.each do |(dx, dy)|
    # Get the height of the adjacent point we're comparing
    adjacent_height = grid[[low_point.first + dx, low_point.last + dy]]
    # If the height is less than the current point's height and less than 9, it's part of the basin
    if grid[low_point] < adjacent_height && adjacent_height < 9
      # Recurse on the adjacent point to keep exploring the basin, adding each point it visits
      explore_basin([low_point.first + dx, low_point.last + dy], grid).each do |point|
        visited_nodes << point
      end
    end
  end

  # Remove any duplicate points this exploration does not prevent re-visiting nodes
  visited_nodes.uniq
end

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
  end
end



basin_sizes = []
# For every low point found, explore the basin and add it to the list of basin sizes
low_points.each do |low_point|
  visited_nodes = explore_basin(low_point, grid)
  basin_sizes << visited_nodes.length
end

# Get the three largest basin sizes by sorting the array and getting the last three elements
puts basin_sizes.sort.last(3).inject(:*)
