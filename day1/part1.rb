depths = File.read('in.txt').chomp.split("\n").map(&:to_i)

inc = 0
dec = 0

depths.each_with_index do |depth, index|
  next if index == 0
  inc += 1 if depth > depths[index-1]
  dec += 1 if depth < depths[index-1]
end

puts "Increases: #{inc}"
puts "Decreases: #{dec}"
