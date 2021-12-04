depths = File.read('in.txt').chomp.split("\n").map(&:to_i)

inc = 0
dec = 0
eq = 0

window = []

depths.each do |depth|
  prev_sum = window.inject(:+)
  window << depth

  next if window.length <= 3

  window = window.drop(1)
  puts "window: #{window}, sum: #{window.inject(:+)}, prev: #{prev_sum}, cur: #{window.inject(:+)}  inc: #{window.inject(:+) > prev_sum}"
  inc += 1 if window.inject(:+) > prev_sum
  dec += 1 if window.inject(:+) < prev_sum
  eq += 1 if window.inject(:+) == prev_sum
end

puts "Increases: #{inc}"
puts "Decreases: #{dec}"
puts "No change: #{eq}"
