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
    # binding.pry
    result.map do |node|
      node_hashed(node)
    end
  end

  def traverse_left(start_node, queue, result)
    if start_node.nil?
      return result
    end
    until start_node.lower_link.nil?
      queue_higher_link_then_start_node(start_node, queue)
      start_node = start_node.lower_link
      if start_node.lower_link.nil?
        queue << start_node
      end
    end
    result << queue.pop #q5,q3
    #start node is far left node
    track_up_and_or_right(start_node, queue, result)
    # result
  end

#could create traverse_right and track_up
  def track_up_and_or_right(start_node, queue, result)
    if start_node.higher_link.nil? #(visit go up)
      if queue[0] #queue.length > 0, queue.length > 1
        result << queue.pop #q4
      end
      traverse_left(queue[-1], queue, result) # start_node = queue[-1]
    elsif start_node.higher_link
      queue_higher_link_then_start_node(start_node.higher_link, queue) # start_node = start_node.higher_link
      result << queue.pop
      traverse_left(start_node.higher_link, queue, result)
    else
      result << queue.pop
      track_up_and_or_right(queue[-1], queue, result) # start_node = queue[-1]
    end
  end

  def queue_higher_link_then_start_node(start_node, queue)
    if start_node.higher_link
      queue << start_node.higher_link
    end
    queue << start_node
    if queue[0] == queue [-1] && queue.count > 2
      queue.shift
    end
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
      if line[0..1].to_i < 10
        line.prepend("0")
      end
      movie = line.chomp.split(", ")
      added = insert(movie[0].to_i, movie[1])
      if added == false
        movies_added += 0
      else
        movies_added += 1
      end

    end
    movies_added
  end

  def health(tree_level, current_depth=0)

  end

end
