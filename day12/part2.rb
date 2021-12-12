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
    # Adding one more condition from the previous part - being able to explore a single small
    # cave one extra time per path
    # To find out whether we've already visited any small cave more than once, get all nodes in the path
    # for small caves. If the length of this is the same after removing duplicate nodes, that means a small
    # node has not been explored more than once in the current path
    lowercase_nodes_in_path = path.filter { |path| lowercase?(path) }
    small_cave_visited_more_than_once = lowercase_nodes_in_path.length > lowercase_nodes_in_path.uniq.length

    # If the node to visit is a small case(lowercase name), has already been visited, and a small cave has already been
    # explored more than once, then we can skip
    next if lowercase?(connected_node) && path.include?(connected_node) && small_cave_visited_more_than_once
    search_paths(graph, connected_node, ending, path, paths)
  end
end



input = File.read('in.txt').chomp.split("\n")

graph = Hash.new { |h, k| h[k] = [] }

# Load the input into the graph
input.each do |line|
  start, ending = line.split('-')
  # Add the two edges to the graph, but with an extra condition to remove connections from an edge back to the start or end
  graph[start] << ending unless ending == 'start' || start == 'end'
  graph[ending] << start unless start == 'start' || ending == 'end'
end

paths = []
search_paths(graph, 'start', 'end', [], paths)

puts paths.uniq.length
