# Takes in a series of encoded seven segment mappings and decodes them to use the standard in-order layout
def create_segment_mapping(patterns)
  mapping = {}

  # Find the patterns that represent 1, 4, and 7 since they are unique by the number of segments turned on
  one = patterns.select { |p| p.length == 2 }.first
  four = patterns.select { |p| p.length == 4 }.first
  seven = patterns.select { |p| p.length == 3 }.first

  # We can figure out the first segment(a) by finding the character that's in a 7 but not in 1
  mapping[:a] = (seven.split('') - one.split('')).first

  'abcedfg'.split('').each do |letter|
    mapping[:e] = letter if patterns.join.count(letter) == 4 # e appears in 4 numbers
    mapping[:b] = letter if patterns.join.count(letter) == 6 # b appears in 6 numbers
    mapping[:f] = letter if patterns.join.count(letter) == 9  # f appears in 9 numbers

    # a and c appear in 8 numbers, but we already know a from differentiating 1 and 7
    mapping[:c] = letter if patterns.join.count(letter) == 8 && letter != mapping[:a]
  end

  # We can find d by taking the pattern for 4 and finding the character that hasn't been mapped yet
  # This works because we know segments b, c, and f, and all the segments for 4, so the segment in 4
  # that is not b, c, or f is d
  mapping[:d] = (four.split('') - [mapping[:b], mapping[:c], mapping[:f]]).first

  # g is the last remaining unused segment
  mapping[:g] = ('abcedfg'.split('') - mapping.values).first
  mapping
end

# Takes an encoded digit and decoding map and returns the integer value that is decoded
def encoded_digit_to_number(digit, segment_mapping)
  # Handle basic cases where we don't need to decode
  return 1 if digit.length == 2
  return 7 if digit.length == 3
  return 4 if digit.length == 4
  return 8 if digit.length == 7

  # Mapping of each seven segment combination to the number it is displaying, with segments in order
  decoded_segment_mapping = {
    'abcefg'  => 0,
    'cf'      => 1,
    'acdeg'   => 2,
    'acdfg'   => 3,
    'bcdf'    => 4,
    'abdfg'   => 5,
    'abdefg'  => 6,
    'acf'     => 7,
    'abcdefg' => 8,
    'abcdfg'  => 9
  }

  decoded_digit = []
  # Using the decoding map, take each character in the encoded digit and decode it to the in-order seven segment letter
  digit.split('').each do |c|
    decoded_digit << segment_mapping.key(c).to_s
  end

  # Sort the decoded digit's characters and use that to index into the decoded segments to get the number
  decoded_segment_mapping[decoded_digit.sort.join]
end

sum = 0

input = File.read('in.txt').chomp.split("\n")
input.each do |line|
  # Separate the encoded patterns from the digits into their own arrays
  patterns, digits = line.split(' | ').map { |str| str.split(' ') }

  # Using the encoded patterns, create the mapping of the pattern to the decoded seven segment patterns
  segments = create_segment_mapping(patterns)

  digit_sum = 0
  # Convert each encoded digit to a number using the decoded mapping table.
  # This is done in reverse order to make it easier to sum up
  # 1234 = (1 * 10^3) + (2 * 10^2) + (3 * 10^1) + (4 * 10^0)
  digits.reverse.each_with_index do |digit, index|
    sum += encoded_digit_to_number(digit, segments) * 10 ** index
  end
end

puts sum
