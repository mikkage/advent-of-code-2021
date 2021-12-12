# Returns whether or not a string is all lowercase or not
def lowercase?(str)
  str.downcase == str
end

# Returns an array of all paths between the given points in the graph
def search_paths(graph, starting, ending, path, paths)
  # Add the current point we're on to the path
  # NOTE- Using += only affects the variable, not the object like << does. This is used so that the path
  # object is not being modified directly since it's getting passed around in recursive calls
  path += [starting]

  # If the current point is the destination, then we've completed the path and can return
  if starting == ending
    paths << path
    return
  end

  # If we're not at the end of the path, then recurse on every connected node
  graph[starting].each do |connected_node|
    # If the node to visit is a small case(lowercase name) and has already been visited, then we can skip
    next if lowercase?(connected_node) && path.include?(connected_node)
    search_paths(graph, connected_node, ending, path, paths)
  end
end

graph = Hash.new { |h, k| h[k] = [] }

input = File.read('in.txt').chomp.split("\n")
# Load the input into the graph
input.each do |line|
  start, ending = line.split('-')
  graph[start] << ending
  graph[ending] << start
end

paths = []
search_paths(graph, 'start', 'end', [], paths)
puts paths.length
