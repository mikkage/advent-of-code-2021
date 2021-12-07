timers = File.read('in.txt').chomp.split(',').map(&:to_i)

days = 80

days.times do
  # Used to store any new fish that would be added during each day since they can't be added during the iteration
  new_timers = []

  timers.each_with_index do |timer, index|
    # If the timer is down to 0, reset it to 6 and set a new 8 day timer to be added later
    if timer == 0
      timers[index] = 6
      new_timers << 8
    else
      # If it's not 0, then just subtract one from the current timer value
      timers[index] -= 1
    end
  end
  # Add any new timers into the array before starting the next day's iteration
  timers.push(new_timers).flatten!
end

puts "Total fish after #{days} days: #{timers.length}"
