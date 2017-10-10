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
    end
  end

  def find_parent(new_node, start_node=root)
    new_rating = new_node.rating
    if new_node.rating == start_node.rating
      return false
    end
    if evaluate_greater_or_less_and_if_link_nil(new_rating, start_node)
      set_node_link(new_node, start_node)
    elsif less_than_and_link_true(new_rating, start_node)
      find_parent(new_node, start_node.lower_link)
    else
      find_parent(new_node, start_node.higher_link)
    end
  end

  def include?(rating_to_find, start_node=root)
    if rating_to_find == start_node.rating
      true
    elsif evaluate_greater_or_less_and_if_link_nil(rating_to_find, start_node)
      false
    else
      child_node = choose_child(rating_to_find, start_node)
      include?(rating_to_find, child_node)
    end
  end

  def depth_of(rating_to_find, start_node=root, tree_depth=0)
    if rating_to_find == start_node.rating
      tree_depth
    elsif evaluate_greater_or_less_and_if_link_nil(rating_to_find, start_node)
      nil
    else
      tree_depth += 1
      child_node = choose_child(rating_to_find, start_node)
      depth_of(rating_to_find, child_node, tree_depth)
    end
  end

  def node_hashed(node)
    # nodes = {}
    # nodes["#{node.movie_title}"] = node.rating
    # binding.pry
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
    queue = []
    result = []
    result = traverse_left(start_node, queue, result)
    result.map do |node|
      node_hashed(node)
    end
  end

  def traverse_left(start_node, queue, result)
    return result if start_node.nil?
    until start_node.lower_link.nil?
      manage_queue(start_node, queue)
      start_node = start_node.lower_link
      queue << start_node if start_node.lower_link.nil?
    end
    result << queue.pop
    hop_right(start_node, queue, result)
  end

  def hop_right(start_node, queue, result)
    if start_node.higher_link.nil?
      result << queue.pop if queue[0]
      traverse_left(queue[-1], queue, result)
    elsif start_node.higher_link
      manage_queue(start_node.higher_link, queue)
      result << queue.pop
      traverse_left(start_node.higher_link, queue, result)
    else
      result << queue.pop
      hop_right(queue[-1], queue, result)
    end
  end

  def manage_queue(start_node, queue)
    queue << start_node.higher_link if start_node.higher_link
    queue << start_node
    queue.shift if queue[0] == queue [-1] && queue.count > 2
  end

  def choose_child(rating_to_find, start_node)
    if less_than_and_link_true(rating_to_find, start_node)
      start_node.lower_link
    else
      start_node.higher_link
    end
  end

  def set_node_link(new_node, parent_node)
    if new_node.rating > parent_node.rating
      parent_node.higher_link = new_node
    else
      parent_node.lower_link = new_node
    end
  end

  def less_than_and_link_true(new_rating, start_node)
    start_node.rating > new_rating
  end

  def less_than_and_link_nil(new_rating, start_node)
    start_node.rating > new_rating && start_node.lower_link.nil?
  end

  def greater_than_and_link_true(new_node, start_node)
    start_note.rating < new_node.rating
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
      added = insert(movie[0].to_i, movie[1])
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

#node_health = [score, 1+num_children, 1+num_children/1+total_children]
  def health(tree_level_to_test=0)
  end

  def count_nodes(start_node=root)
    number_of_nodes = sort(start_node).count
  end

end
#try out errors in input, edge cases
