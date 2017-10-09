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
    {"#{node.movie_title}" => node.rating}
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
    sorted = []
    sorted << min
    sorted.find do |node|
      node_hashed(node)
      sorted << parent_node
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




end
