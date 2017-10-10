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

    assert_equal 0, tree.depth_of(61)
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
    tree.manage_queue(tree.root, queue)

    assert_equal [99, 61], [queue[0].rating, queue[1].rating]
  end

  def test_traverse_left
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    queue = []
    result = []
    tree.traverse_left(tree.root, queue, result)

    assert_equal result, result
  end

  def test_sort_2_nodes
    tree = Tree.new()
    tree.insert(61, "Test 3 sort")
    tree.insert(16, "Johnny English")

    assert_equal [{"Johnny English"=>16},
                  {"Test 3 sort"=>61}
                  ], tree.sort
  end

  def test_sort_3_nodes
    tree = Tree.new()
    tree.insert(61, "Test 3 sort")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")

    assert_equal [{"Johnny English"=>16},
                  {"Logan"=>25},
                  {"Test 3 sort"=>61}
                  ], tree.sort
  end

  def test_sort_6_nodes
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [{"Wonderwoman"=>5},
                  {"Johnny English"=>16},
                  {"Logan"=>25},
                  {"Anchorman"=>54},
                  {"Zoolander"=>61},
                  {"test 6 sort"=>99}
                  ], tree.sort
  end

  def test_sort_9_nodes
    tree = Tree.new()
    tree.insert(55, "Dodgeball")
    tree.insert(89, "Rouge One")
    tree.insert(39, "SpaceBalls")
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 9 sort")
    tree.insert(54, "Anchorman")

    assert_equal [{"Wonderwoman"=>5},
                  {"Johnny English"=>16},
                  {"Logan"=>25},
                  {"SpaceBalls"=>39},
                  {"Anchorman"=>54},
                  {"Dodgeball"=>55},
                  {"Zoolander"=>61},
                  {"Rouge One"=>89},
                  {"test 9 sort"=>99}
                  ], tree.sort

    assert_equal 9, tree.sort.count

  end

  def test_load_file
    tree = Tree.new()
    file_name = "./lib/movies.txt"
    tree.insert(55, "Dodgeball")
    tree.insert(89, "Rouge One")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    movies_added = tree.load_file(file_name)

    assert_equal 95, movies_added
  end

  def test_count_nodes
    tree = Tree.new()
    tree.insert(55, "Dodgeball")
    tree.insert(89, "Rouge One")
    tree.insert(39, "SpaceBalls")
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 9 sort")
    tree.insert(54, "Anchorman")
    total_nodes = tree.count_nodes
    root_lower_link_total_nodes = tree.count_nodes(tree.root.lower_link)
    root_higher_link_total_nodes = tree.count_nodes(tree.root.higher_link)

    assert_equal 9, total_nodes
    assert_equal 5, root_lower_link_total_nodes
    assert_equal 3, root_higher_link_total_nodes
  end

  def test_find_children_depth_1
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [tree.root.lower_link,
                  tree.root.higher_link
                  ], tree.find_children([tree.root])
  end

  def test_find_children_depth_2
    skip
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [tree.root.lower_link.lower_link,
                  tree.root.lower_link.higher_link
                  ], tree.health(1)
  end

  def test_find_children_depth_3
    skip
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [tree.root.lower_link.higher_link.higher_link
                  ], tree.health(2)
  end

  def test_health_of_root
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [[61, 6, 100]], tree.health
  end

  def test_health_of_level_1
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [[16, 4, 66],[99,1,16]], tree.health(1)
  end

  def test_health_of_level_2
    tree = Tree.new()
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 6 sort")
    tree.insert(54, "Anchorman")

    assert_equal [[5, 1, 16],[25,2,33]], tree.health(2)
  end

  def test_health_on_another_collection
    tree = Tree.new()
    tree.insert(55, "Dodgeball")
    tree.insert(89, "Rouge One")
    tree.insert(39, "SpaceBalls")
    tree.insert(61, "Zoolander")
    tree.insert(16, "Johnny English")
    tree.insert(25, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "test 9 sort")
    tree.insert(54, "Anchorman")

    assert_equal [[55, 9, 100]], tree.health(0)
    assert_equal [[39, 5, 55],
                  [89, 3, 33]
                  ], tree.health(1)
    assert_equal [[16, 3, 33],
                  [54, 1, 11],
                  [61, 1, 11],
                  [99, 1, 11]
                  ], tree.health(2)
    assert_equal [[5, 1, 11], [25, 1, 11]], tree.health(3)
  end

end
