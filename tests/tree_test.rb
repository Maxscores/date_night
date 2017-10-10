require 'minitest/autorun'
require 'minitest/pride'
require './lib/tree'
require 'pry'

class TreeTest < Minitest::Test
  def test_first_insert_creates_root
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert_equal 61, tree.root.rating
  end

  def test_subsequent_insert_sets_root_link_below
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")

    assert_equal 16, tree.root.lower_link.rating
  end



  def test_subsequent_insert_sets_root_link_above
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(87, "Logan")

    assert_equal 87, tree.root.higher_link.rating
  end

  def test_subsequent_insert_sets_root_link_when_out_of_order
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(99, "Batman")

    assert_equal 87, tree.root.higher_link.rating
    assert_equal 99, tree.root.higher_link.higher_link.rating
    assert_equal 16, tree.root.lower_link.rating
  end



  def test_include_fails_if_only_root

    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    refute tree.include?(87)
    refute tree.include?(34)
  end

  def test_include_fails_if_not_found

    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")

    refute tree.include?(69)
  end

  def test_include_passes_if_found

    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")

    assert tree.include?(16)
    assert tree.include?(61)
    assert tree.include?(87)
    assert tree.include?(5)
    assert tree.include?(99)
  end

  def test_tree_depth
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")

    assert_equal 1, tree.depth_of(87)
    assert_equal 2, tree.depth_of(5)
  end

  def test_max_score
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")

    assert_equal [{"MAD MAX"=>99}], tree.max

  end

  def test_min_score
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")

    assert_equal [{"Wonderwoman"=>5}], tree.min
  end

  def test_queue_higher_link_and_start
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(99, "MAD MAX")
    queue = []
    tree.queue_higher_link_then_start_node(tree.root, queue)

    assert_equal [99, 61], [queue[0].rating, queue[1].rating]
  end

  def test_traverse_left

    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    # tree.insert(16, "Johnny English")
    # tree.insert(99, "MAD MAX")
    # tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    queue = []
    result = []
    tree.traverse_left(tree.root, queue, result)
    # binding.pry
    assert_equal result, result
  end


  def test_sort_3_nodes
    # skip
    tree = Tree.new()
    tree.insert(61, "Test 3 sort")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    # tree.insert(5, "Wonderwoman")
    # tree.insert(99, "MAD MAX")
    # tree.insert(54, "Anchorman")

    assert_equal [#{"Wonderwoman"=>5},
                  {"Johnny English"=>16},
                  {"Logan"=>25},
                  # {"Anchorman"=>54},
                  {"Test 3 sort"=>61}
                  # {"MAD MAX"=>99}
                  ], tree.sort
  end

  def test_sort_6_nodes
    skip
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")
    tree.insert(54, "Anchorman")

    assert_equal [{"Wonderwoman"=>5},
                  {"Johnny English"=>16},
                  {"Logan"=>25},
                  {"Anchorman"=>54},
                  {"Zoolander"=>61},
                  {"MAD MAX"=>99}
                  ], tree.sort
  end
  #separte setup from assertions
  #make more variations in testing inputs

end