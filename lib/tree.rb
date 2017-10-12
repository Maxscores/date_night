require './lib/node'

class Tree
  attr_accessor :root

  def initialize()
    @root = nil
  end

  def insert(rating, movie_title)
    new_node = Node.new(rating, movie_title)
    if @root
      find_parent(new_node)
    else
      @root = new_node
      root.depth = 0
    end
  end

  def find_parent(new_node, start_node=root, tree_depth=0)
    return false if new_node.rating == start_node.rating
    if evaluate_greater_or_less_and_if_link_nil(new_node.rating, start_node)
      set_node_link(new_node, start_node)
      new_node.depth = tree_depth + 1
    elsif less_than(new_node.rating, start_node)
      tree_depth += 1
      find_parent(new_node, start_node.lower_link, tree_depth)
    else
      tree_depth += 1
      find_parent(new_node, start_node.higher_link, tree_depth)
    end
  end

  def include?(rating_to_find, start_node=root)
    if rating_to_find == start_node.rating
      start_node
    elsif evaluate_greater_or_less_and_if_link_nil(rating_to_find, start_node)
      false
    else
      child_node = choose_child_to_follow(rating_to_find, start_node)
      include?(rating_to_find, child_node)
    end
  end

  def depth_of(rating_to_find, start_node=root, tree_depth=0)
    node = include?(rating_to_find)
    node.depth
  end

  def choose_child_to_follow(rating_to_find, start_node)
    if less_than(rating_to_find, start_node)
      start_node.lower_link
    else
      start_node.higher_link
    end
  end

  def node_hashed(node)
    if node.nil?
      return
    else
      {"#{node.movie_title}" => node.rating}
    end
  end

  def max(start_node=root)
    until start_node.higher_link == nil
      start_node = start_node.higher_link
    end
    [node_hashed(start_node)]
  end

  def min(start_node=root)
    until start_node.lower_link == nil
      start_node = start_node.lower_link
    end
    [node_hashed(start_node)]
  end

  def sort(start_node=root)
    #mode: s
    result = traverse_tree(start_node, "s")
    result.map do |node|
      node_hashed(node)
    end
  end

  def traverse_mode(mode)
    if mode == 'l'
      0
    elsif mode == 's' || mode == 'h'
      []
    end
  end

  def traverse_tree(start_node, mode, queue=[], result=nil)
    result = traverse_mode(mode) if result.nil?
    return result if start_node.nil?
    sort_single_node(start_node, queue)
    start_node, queue, result = traverse_left(start_node, queue, result)
    queue, result = pop_queue(mode, queue, result)
    hop_right(start_node, mode, queue, result)
  end

  def pop_queue(mode, queue, result)
    if mode == 's'
      result << queue.pop
    else
      queue.pop
    end
    return queue, result
  end

  def sort_single_node(start_node, queue)
    if start_node.lower_link.nil? && queue.empty?
      manage_queue(start_node, queue)
    end
  end

  def traverse_left(start_node, queue, result)
    until start_node.lower_link.nil?
      manage_queue(start_node, queue)
      start_node = start_node.lower_link
      queue << start_node if start_node.lower_link.nil?
    end
    return start_node, queue, result
  end

  def hop_right(start_node, mode, queue, result)
    if start_node.higher_link.nil?
      no_higher_link(start_node, mode, queue, result)
    elsif start_node.higher_link
      has_higher_link(start_node, mode, queue, result)
    else
      queue, result = pop_queue(mode, queue, result)
      hop_right(queue.last, mode, queue, result)
    end
  end

  def has_higher_link(start_node, mode, queue, result)
    manage_queue(start_node.higher_link, queue)
    queue, result = pop_queue(mode, queue, result)
    traverse_tree(start_node.higher_link, mode, queue, result)
  end

  def no_higher_link(start_node, mode, queue, result)
    queue, result = pop_queue(mode, queue, result) if queue.first
    result += 1 if mode == 'l'
    if mode == 'h'
      result << start_node.rating
      queue.count.times do |time| #what causes duplicates
        queue.pop if queue[-(time)] == queue[-(time+2)]
      end
    end
    traverse_tree(queue.last, mode, queue, result)
  end

  def manage_queue(start_node, queue)
    queue << start_node.higher_link if start_node.higher_link
    queue << start_node
    queue.shift if queue.first == queue.last && queue.count > 2
  end


  def set_node_link(new_node, parent_node)
    if new_node.rating > parent_node.rating
      parent_node.higher_link = new_node
    else
      parent_node.lower_link = new_node
    end
  end

  def if_no_children(start_node)
    start_node.higher_link.nil? && start_node.lower_link.nil?
  end

  def less_than(new_rating, start_node)
    start_node.rating > new_rating
  end

  def less_than_and_link_nil(new_rating, start_node)
    start_node.rating > new_rating && start_node.lower_link.nil?
  end

  def greater_than_and_link_nil(new_rating, start_node)
    start_node.rating < new_rating && start_node.higher_link.nil?
  end

  def evaluate_greater_or_less_and_if_link_nil(new_rating, start_node)
    greater_and_nil = greater_than_and_link_nil(new_rating, start_node)
    less_and_nil = less_than_and_link_nil(new_rating, start_node)
    greater_and_nil || less_and_nil
  end

  def load_file(file_name)
    file = File.readlines(file_name)
    movies_added = 0
    file.each do |line|
      movie = line.chomp.split(", ")
      added = insert(movie.first.to_i, movie.last)
      movies_added = check_if_added(added, movies_added)
    end
    movies_added
  end

  def check_if_added(added, movies_added)
    if added == false
      movies_added += 0
    else
      movies_added += 1
    end
  end

  def health(depth_to_test=0)
    nodes_at_level = [root]
    depth_to_test.times do |time|
      nodes_at_level = find_children(nodes_at_level)
    end
    create_health_array(nodes_at_level)
  end

  def create_health_array(nodes_at_level)
    nodes_at_level.map do |node|
      node_health = []
      node_health << node.rating
      node_health << count_nodes(node)
      node_health << (100*count_nodes(node) / count_nodes(@root))
    end
  end

  def find_children(nodes_at_level)
    children = []
    nodes_at_level.each do |node|
      children << node.lower_link if node.lower_link
      children << node.higher_link if node.higher_link
    end
    children
  end

  def count_nodes(start_node=root)
    sorted_nodes = sort(start_node)
    sorted_nodes.delete(nil)
    if sorted_nodes[-1] == sorted_nodes[-2]
      sorted_nodes.pop
    end
    sorted_nodes.count
  end

  def leaves
    traverse_tree(@root, 'l')
  end

  def height
    #mode: h
    leaves = traverse_tree(@root, 'h')
    # binding.pry
    leaf_heights = leaves.map do |leaf|
      depth_of(leaf)
    end
    leaf_heights.max
  end

end
#try out errors in input, edge cases
