input = File.read('in.txt').chomp.split("\n")

template = input.first
rules = {}

# Load the rules into a hash where the current sequence is mapped to the element to add to the sequence
input[2..-1].each do |line|
  key, value = line.split(' -> ')
  rules[key] = value
end

# To make this run for part 2, instead of actually maintaining the template as elements are added,
# just keep track of the number of times each element occurs

# Create the initial counts of each element
counts = Hash.new(0)
template.chars.each_with_index do |char, index|
  char_pair = template[index..index+1]
  next if rules[char_pair].nil?
  counts[char_pair] += 1
end

40.times do
  # Store the original counts in a new hash, then overwrite the original counts to an empty hash
  new_counts = counts.dup
  counts = Hash.new(0)

  # To keep track of the counts while inserting new elements, you add count of the original element pair
  # to two keys in the hash:
  #   1. The first element in the original pair and the new element being added
  #   2. The new element being added and the second element in the original pair
  # EX: Rule - PP -> B
  #     counts['PP'] => 5
  #     counts['PB'] += 5
  #     counts['BP'] += 5
  new_counts.each do |k, v|
    new_char = rules[k]
    counts[k[0] + new_char] += v
    counts[new_char + k[1]] += v
  end
end

# Get the totals for each element
totals = Hash.new(0)
counts.each do |k, v|
    totals[k[0]] += v
end
# Since we look at pairs, the last element is not counted above, so just add it in to the right key
totals[template.chars.last] += 1

values = totals.values
puts values.max - values.min
