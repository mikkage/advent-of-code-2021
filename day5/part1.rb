# Marks a point on the grid by incrementing the value at x,y by 1
def mark_on_grid(grid, x, y)
  # Initialize a new hash and the key at x,y to 0 if needed
  grid[y] = {} if grid[y].nil?
  grid[y][x] = 0 if grid[y][x].nil?

  # Increment the value at the coordinate
  grid[y][x] += 1
end

input = File.read('in.txt').chomp.split("\n")

# Note - The grid is accessed in (y,x) instead of (x,y). grid[y][x]
grid = {}

input.each do |line|
  # Parse the input by splitting it on ' -> '. The first element is the initial x,y value, the second is final x,y value
  start, dest = line.split(' -> ')
  start_x, start_y = start.split(',').map { |str| str.to_i }
  dest_x, dest_y = dest.split(',').map { |str| str.to_i }

  # Determine which way the line goes
  # If the original and destination x coordinates are the same, then it's a vertial line
  # If the original and destination y coordinates are the same, then it's a horizontal line
  if start_x == dest_x
    # If the destination y is lower than the original y, swap the two so the range will work correctly
    start_y, dest_y = dest_y, start_y if dest_y < start_y

    # Mark each point on the grid between the two y coordinates
    (start_y..dest_y).each do |y|
      mark_on_grid(grid, start_x, y)
    end
  elsif start_y == dest_y
    # If the destination x is lower than the original x, swap the two so the range will work correctly
    start_x, dest_x = dest_x, start_x if dest_x < start_x

    # Mark each point on the grid between the two x coordinates
    (start_x..dest_x).each do |x|
      mark_on_grid(grid, x, start_y)
    end
  end
end

# Print grid
# (0..9).each do |y|
#   l = ''
#   (0..9).each do |x|
#     val = grid.dig(y, x) || '.'
#     l += val.to_s
#   end
#   puts l
# end

overlapping_spaces = 0
# Search each space in the grid for spaces where the value is greater than one.
# Add that number of spaces to the total for the final result
grid.keys.each do |k|
  overlapping_spaces += grid[k].values.find_all { |v| v > 1 }.length
end

puts "Number of spaces overlapped: #{overlapping_spaces}"
