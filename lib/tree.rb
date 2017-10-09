require './lib/node'

class Tree
  attr_accessor :root, :nodes

  def initialize()
    # @root = nil
    @nodes = [] # nodes[0] is root node
    @root = nil
  end

  def insert(rating, movie_title)
    new_node = Node.new(rating, movie_title) #how to make class global
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

  def crawler(match_rating, crawler_returns, start_node=root)
    # use *args to create array of conditions
    start_rating = start_node.rating
    binding.pry
    if start_rating == match_rating
      crawler_returns[0]
    elsif start_rating < match_rating && start_node.higher_link.nil?
      crawler_returns[1]
    elsif start_rating > match_rating && start_node.lower_link.nil?
      crawler_returns[2]
    elsif start_rating < match_rating
      crawler_returns[3]
    elsif start_rating > match_rating
      crawler_returns[4]
    end
  end

#need to figure out why this is erroring...
  def find_parent_node(start_node=root)
    match_rating = nodes[-1].rating
    crawler_returns = [nil,
                       start_node,
                       start_node,
                       crawler(match_rating,
                               crawler_returns,
                               find_linked_node(start_node.higher_link)
                               ),
                       crawler(match_rating,
                               crawler_returns,
                               find_linked_node(start_node.lower_link)
                               )
                      #  find_parent_node(find_linked_node(start_node.lower_link))
                       ]

    crawler(match_rating, crawler_returns, start_node)

    # start_rating = start_node.rating
    # if start_rating == new_rating
    # elsif start_rating < new_rating && start_node.higher_link.nil?
    #   return start_node
    # elsif start_rating > new_rating && start_node.lower_link.nil?
    #   return start_node
    # elsif start_rating < new_rating
    #   find_parent_node(find_linked_node(start_node.higher_link))
    # elsif start_rating > new_rating
    #   find_parent_node(find_linked_node(start_node.lower_link))
    # end
  end

  def find_linked_node(rating_to_find)
    nodes.each do |node|
      if node.rating == rating_to_find
        return node
      end
    end
  end

  def include?(rating_to_find, start_node=root)
    start_rating = start_node.rating
    if start_rating == rating_to_find
      true
    elsif start_rating > rating_to_find && start_node.lower_link.nil?
      false
    elsif start_rating < rating_to_find && start_node.higher_link.nil?
      false
    elsif start_rating > rating_to_find
      include?(rating_to_find, find_linked_node(start_node.lower_link))
    elsif start_rating < rating_to_find
      include?(rating_to_find, find_linked_node(start_node.higher_link))
    end
  end

  def depth_of(rating_to_find, tree_depth=0, start_node=root)
    start_rating = start_node.rating
    if start_rating == rating_to_find
      tree_depth
    elsif start_rating > rating_to_find && start_node.lower_link.nil?
      nil
    elsif start_rating < rating_to_find && start_node.higher_link.nil?
      nil
    elsif start_rating > rating_to_find
      tree_depth += 1
      depth_of(rating_to_find, tree_depth, find_linked_node(start_node.lower_link))
    elsif start_rating < rating_to_find
      tree_depth += 1
      depth_of(rating_to_find, tree_depth, find_linked_node(start_node.higher_link))
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
    #traverse down to lowest node, grab it, then go to its parent, check for a
    #higher_link and grab that, then go back to the parent and take that. move
    #back up to the parent's parent and check for a higher_link, grab that, etc.
  end


end
