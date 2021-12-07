timers = File.read('in.txt').chomp.split(',').map(&:to_i)

# Using a different more efficient approach than the previous part - Was still calculating after 5 minutes
# Instead of storing things in an array, use a hash where the key is the number of days for the timer
# and the value is the number of fish with that value for its counter

# Load the initial data into a hash
timers_hash = {}
timers_hash.default = 0
timers.each do |t|
  timers_hash[t] += 1
end
timers = timers_hash

days = 256

days.times do
  # Create a new hash to represent what it looks like after the current day is complete
  # 0-7 in the new hash is basic - take each value in k in the original hash and
  # set k-1 to that value in the new hash
  new_timers = {}
  new_timers[0] = timers[1]
  new_timers[1] = timers[2]
  new_timers[2] = timers[3]
  new_timers[3] = timers[4]
  new_timers[4] = timers[5]
  new_timers[5] = timers[6]
  new_timers[6] = timers[7]
  new_timers[7] = timers[8]

  # Special cases for fish at 0 at the start of the iteration
  # The value of the new hash for timers of 8 will be the original number of timers at 0(adding new timers)
  new_timers[8] = timers[0]
  # The value of the new hash for timers of 6 will have the number of timers at 0 added to it(resetting timers at 0)
  new_timers[6] += timers[0]

  # Overwrite the timers with the new values calculated
  timers = new_timers
end

# Sum up the values of each key to find the total number of fish
sum = 0
timers.keys.each do |k|
  sum += timers[k]
end

puts "Total fish after #{days} days: #{sum}"
