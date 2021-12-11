$total_flashes = 0

# Flashes the given coordinate on the grid
# Will trigger a new flash on any surrounding point that meets the requirements to flash
def flash(coordinates, grid)
  # Since this is called recursively on any surrounding points that should flash, we need
  # to make sure to skip any points that have already flashed as it's possible to visit the same
  # coordinates multiple times when multiple flashes are chained
  return grid if grid[coordinates][:flashed]

  # Mark the current point as flashed and increment the global flash counter
  grid[coordinates][:flashed] = true
  $total_flashes += 1

  # Create an array of the coordinates of each surrounding point
  x = coordinates.first
  y = coordinates.last
  surrounding_coordinates = [
    [x+1, y+1],
    [x+1, y],
    [x+1, y-1],
    [x, y-1],
    [x-1, y-1],
    [x-1, y],
    [x-1, y+1],
    [x, y+1],
  ]

  surrounding_coordinates.each do |coordinate|
    # If the surrounding point is out of bounds, do nothing
    next if grid[coordinate].nil?

    # Otherwise add one to the energy and flash the point if the increase has made it eligible to flash
    grid[coordinate][:energy] += 1
    grid = flash(coordinate, grid) if grid[coordinate][:energy] > 9
  end

  # Return the updated grid after all surrounding flashes have been done
  grid
end

input = File.read('in.txt').chomp.split("\n")

# Store the grid in a hash where the key is an array with two numbers, the x and y coordinates
# and the value is another hash with the energy level and whether it has been flashed this round
grid = {}
grid_size = input.first.length

# Load the input into the grid
input.each_with_index do |line, y|
  line.split('').each_with_index do |energy_level, x|
    grid[[x,y]] = { :energy => energy_level.to_i, :flashed => false }
  end
end

100.times do
  # Increment the energy in each space
  (0..grid_size-1).each do |y|
    (0..grid_size-1).each do |x|
      coordinates = [x, y]
      grid[coordinates][:energy] += 1
    end
  end

  # Flash any spaces with more than 9 energy
  grid.select { |k, v| v[:energy] > 9 }.each do |coordinate, value|
    # Since flash() updates the grid, it's possible some of the results from grid.select()
    # have been flashes when flashes chain. Just need to do one more quick check that the
    # spot has not flashed and skip calling flash() if it has
    next if grid[coordinate][:flashed]
    grid = flash(coordinate, grid)
  end

  # Reset flashed spots back to 0 energy
  grid.select { |k, v| v[:energy] > 9 }.each do |coordinate, value|
    grid[coordinate][:energy] = 0
    grid[coordinate][:flashed] = false
  end
end

puts "Total flashes: #{$total_flashes}"
