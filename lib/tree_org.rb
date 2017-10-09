require './lib/node'

class Tree
  attr_accessor :root, :nodes

  def initialize()
    @nodes = [] # nodes[0] is root node
    @root = nil
  end

  def insert(rating, movie_title)
    new_node = Node.new(rating, movie_title)
    @nodes << new_node
    if nodes.count > 1
      set_node_link(find_parent_node())
    else
      @root = nodes[0]
    end
  end

  def set_node_link(parent_node)
    if parent_node.rating < nodes[-1].rating
      parent_node.higher_link = nodes[-1].rating
    else
      parent_node.lower_link = nodes[-1].rating
    end
  end

  def find_linked_node(rating_to_find)
    nodes.find do |node|
      node.rating == rating_to_find
    end
  end

  def find_parent_node(start_node=root)
    new_rating = nodes[-1].rating
    start_rating = start_node.rating
    if start_rating == new_rating
    elsif start_rating < new_rating && start_node.higher_link.nil?
      return start_node
    elsif start_rating > new_rating && start_node.lower_link.nil?
      return start_node
    elsif start_rating < new_rating
      find_parent_node(find_linked_node(start_node.higher_link))
    elsif start_rating > new_rating
      find_parent_node(find_linked_node(start_node.lower_link))
    end
  end

  def include?(rating_to_find, start_node=root)
    start_rating = start_node.rating
    if start_rating == rating_to_find
      true
    elsif start_rating < rating_to_find && start_node.higher_link.nil?
      false
    elsif start_rating > rating_to_find && start_node.lower_link.nil?
      false
    elsif start_rating < rating_to_find
      include?(rating_to_find, find_linked_node(start_node.higher_link))
    elsif start_rating > rating_to_find
      include?(rating_to_find, find_linked_node(start_node.lower_link))
    end
  end

  def depth_of(rating_to_find, tree_depth=0, start_node=root)
    start_rating = start_node.rating
    if start_rating == rating_to_find
      tree_depth
    elsif start_rating < rating_to_find && start_node.higher_link.nil?
      nil
    elsif start_rating > rating_to_find && start_node.lower_link.nil?
      nil
    elsif start_rating < rating_to_find
      tree_depth += 1
      depth_of(rating_to_find, tree_depth, find_linked_node(start_node.higher_link))
    elsif start_rating > rating_to_find
      tree_depth += 1
      depth_of(rating_to_find, tree_depth, find_linked_node(start_node.lower_link))
    end
  end

  def max
    node = root
    until node.higher_link == nil
      node = find_linked_node(node.higher_link)
    end
    [{"#{node.movie_title}" => node.rating}]
  end

  def min
    node = root
    until node.lower_link == nil
      node = find_linked_node(node.lower_link)
    end
    [{"#{node.movie_title}" => node.rating}]
  end

  def sort(start_node=root)
    start_rating = start_node.rating
    sorted = []
    #traverse down to lowest node, grab it, then go to its parent take parent, check for a
    #higher_link and grab that, then go back to the parent. move
    #back up to the parent's parent and check for a higher_link, grab that, etc.
    if start_rating == rating_to_find
    elsif start_rating < rating_to_find && start_node.higher_link.nil?
    elsif start_rating > rating_to_find && start_node.lower_link.nil?
    elsif start_rating < rating_to_find
    elsif start_rating > rating_to_find
    end

  end


end
