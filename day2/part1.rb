directions = File.read('in.txt').chomp.split("\n")

depth = 0
horizontal = 0

directions.each do |d|
  direction, distance = d.split(' ')
  distance = distance.to_i
  distance *= -1 if direction == 'up'
  horizontal += distance if direction == 'forward'
  depth += distance if direction == 'up' || direction == 'down'
end

puts "Depth: #{depth}"
puts "Horizontal: #{horizontal}"
puts "Result: #{depth * horizontal}"
