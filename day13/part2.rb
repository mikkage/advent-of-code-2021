# Folds the grid horizontally over the given y coordinate. The bottom half is folder onto the top
def fold_horizontal(grid, y)
  # The spots that need to be 'flipped' are any spots that are marked(#) and have a y-value greater than the folding line
  grid.filter { |k, v| k.last > y && v == '#' }.each do |k, v|
    # To find the coordinate where the point will be flipped to, first find the difference between the y-coordinate
    # of the point and the folding line. The new coordinate would then be (x, folding-y - diff). Could also be (x, y - 2 * diff)
    diff = k.last - y
    new_coordinate = [k.first, y - diff]
    # Once we have the coordinate of the flipped position, overwrite the value in the position
    grid[new_coordinate] = v
    # Reset the original position back to '.' since the original point would no longer be on the grid
    grid[k] = '.'
  end

  grid
end

# Folds the grid vertically over the given x coordinate. The right half is folded onto the left
def fold_vertical(grid, x)
  # The spots that need to be 'flipped' are any spots that are marked(#) and have an x-value greater than the folding line
  grid.filter { |k, v| k.first > x && v == '#' }.each do |k, v|
    # To find the coordinate where the point will be flipped to, first find the difference between the x-coordinate
    # of the point and the folding line. The new coordinate would then be (folding-x - diff, y). Could also be (x - 2 * diff, y)
    diff = k.first - x
    new_coordinate = [x - diff, k.last]
    # Once we have the coordinate of the flipped position, overwrite the value in the position
    grid[new_coordinate] = v
    # Reset the original position back to '.' since the original point would no longer be on the grid
    grid[k] = '.'
  end

  grid
end

input = File.read('in.txt').chomp.split("\n")

grid = {}
grid.default = '.'

folds = []

# Parse input
input.each do |line|
  # Handling the folding instructions that come after the main coordinates
  if line.include?('fold along')
    axis, value = line.split(' ').last.split('=')
    folds << [axis, value.to_i]
    next
  end

  # There's a blank line between the coordinates and the folding instructions that needs to be ignored
  next if line == ''

  # Creating the grid with each coordinate
  x, y = line.split(',')
  coordinates = [x.to_i, y.to_i]
  grid[coordinates] = '#'
end

folds.each do |f|
  grid = fold_horizontal(grid, f.last) if f.first == 'y'
  grid = fold_vertical(grid, f.last) if f.first == 'x'
end

6.times do |y|
  39.times do |x|
    print grid[[x,y]]
  end
  puts ''
end
