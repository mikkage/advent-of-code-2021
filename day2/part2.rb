directions = File.read('in.txt').chomp.split("\n")

depth = 0
horizontal = 0
aim = 0

directions.each do |d|
  direction, distance = d.split(' ')
  distance = distance.to_i

  if direction == 'forward'
    horizontal += distance if direction == 'forward'
    depth += aim * distance if aim != 0
  else
    distance *= -1 if direction == 'up'
    aim += distance
  end
end

puts "Depth: #{depth}"
puts "Horizontal: #{horizontal}"
puts "Aim: #{aim}"
puts "Result: #{depth * horizontal}"
