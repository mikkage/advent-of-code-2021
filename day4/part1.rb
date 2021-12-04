def board_won?(board)
  # Check horizontal lines by getting all of the spots that have been marked
  # If the length of the resulting array is 5, then that means there are 5 marked spaces and the board has won
  board.each do |hz_line|
    marked_spaces = hz_line.select { |space| space[:marked] == true }
    return true if marked_spaces.length == 5
  end


  # Check vertical by doing the same thing as the horizontal check, except transpose the board first
  board.transpose.each do |vrt_line|
    marked_spaces = vrt_line.select { |space| space[:marked] == true }
    return true if marked_spaces.length == 5
  end

  false
end

# Marks a space on the provided board if the value is in the board
def mark_space(board, value)
  board.each do |hz_line|
    hz_line.each do |space|
      if space[:value] == value
        space[:marked] = true
        return
      end
    end
  end
end

input = File.read('in.txt').chomp.split("\n")

draw_order = input.first.strip.split(',')

boards = []

# Remove the first two lines(draw order and a newline before boards)
input = input[2..-1]

# Remove blank lines, then grab each set of 5 lines for each board into its own array
input.delete("\r")
input.each_slice(5) do |board|
  # Parse each set of 5 lines into its own new board and add it to the array of all boards
  parsed_board = []
  board.each do |line|
    line_arr = []
    line.split(' ').each do |num|
      line_arr << { value: num.strip.to_i, marked: false }
    end
    parsed_board << line_arr
  end
  boards << parsed_board
end

winning_board = nil
winning_number = nil

draw_order.each do |draw|
  boards.each do |board|
    # Mark the space on the board if the board contains the drawn number
    mark_space(board, draw.to_i)
    # Check if it won, setting winning_board and winning_number and exit loop if it did
    if board_won?(board)
      winning_board = board
      winning_number = draw.to_i
      break
    end
  end

  break unless winning_board.nil?
end

# Get the sum of all unmarked spaces in the winning board
unmarked_sum = 0
winning_board.each do |hz_line|
  hz_line.select {|x| x[:marked] == false}.each do |unmarked_space|
    unmarked_sum += unmarked_space[:value]
  end
end

puts "Winning number: #{winning_number}"
puts "Sum of unmarked spaces in winning board: #{unmarked_sum}"
puts "Final result: #{winning_number * unmarked_sum}"
