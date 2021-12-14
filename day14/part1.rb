input = File.read('in.txt').chomp.split("\n")

template = input.first
rules = {}

# Load the rules into a hash where the current sequence is mapped to the element to add to the sequence
input[2..-1].each do |line|
  key, value = line.split(' -> ')
  rules[key] = value
end

10.times do
  # Create a temporary template to store the new polymer without modifying the original one during iteration
  temp_template = template.dup

  template.chars.each_with_index do |char, index|
    char_pair = template[index..index+1]
    next if rules[char_pair].nil?

    # Insert the new element into the correct spot. 1 + index is where you would insert the first new element,
    # so you need to take into account each element inserted after the first requires an extra offset.
    # This offset is just 1 * index, so the whole thing can be simplified to 2*index + 1
    temp_template.insert(2 * index + 1, rules[char_pair])
  end

  template = temp_template
end

# Get the count of each element's occurences in the resulting template
counts = Hash.new(0)
template.chars.each do |c|
  counts[c] += 1
end

values = counts.values
puts values.max - values.min
