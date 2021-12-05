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
  # If neither of the above two, then it's a diagonal line
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
  else
    # Diagonal line
    # Not needed for this - If the abosulte value of the change in x and change in y are not the same
    # it's not a 45 degree angle, and can't be used
    next unless (start_x - dest_x).abs == (start_y - dest_y).abs

    # Determine whether x and y are increasing or decreasing between the two points by finding the difference between
    # the starting and ending coordinate. If the starting coordinate is greater than the destination, then
    # we will have to subtract one each iteration to reach the destination. If the starting coordinate is less than
    # the destination, then we have to add one each iteration to reach the destination
    x_increment = start_x > dest_x ? -1 : 1
    y_increment = start_y > dest_y ? -1 : 1

    # Mark the start and ending points on the grid
    mark_on_grid(grid, start_x, start_y)
    mark_on_grid(grid, dest_x, dest_y)

    # Mark the points inbetween the start and ending points on the grid
    # To get the number of times to iterate between the two points, get the absolute value of the difference between
    # either the x or y coordinates(45 degree angle means the difference for x and y are the same)
    # When you subtract 1 from that value, you'll have the number of points that need to be drawn.
    # EX(only a single axis) - If you draw a line from 1 to 5:
    # 1 2 3 4 5     abs(1 - 5) -> 4
    #               4 - 1 = 3
    # 1 _ _ _ 5     Drawing the first and last points, there are 3 remaining to be drawn inbetween the two
    ((start_y - dest_y).abs - 1).times do
      # Add the increment to the x and y coordinates then mark the new point on the grid
      start_x += x_increment
      start_y += y_increment
      mark_on_grid(grid, start_x, start_y)
    end
  end
end

# # Print grid
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
