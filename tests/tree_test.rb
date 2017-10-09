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

  def test_first_sort
    skip
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")

    assert_equal [{"Wonderwoman"=>5},
                  {"Johnny English"=>16}], tree.sort
  end

  def test_sort
    skip
    tree = Tree.new()
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(87, "Logan")
    tree.insert(5, "Wonderwoman")
    tree.insert(99, "MAD MAX")
    assert_equal [{"Wonderwoman"=>5},
                  {"Johnny English"=>16},
                  {"Bill & Ted's Excellent Adventure"=>61},
                  {"Logan"=>87},
                  {"MAD MAX"=>99}], tree.sort
  end
  #separte setup from assertions
  #make more variations in testing inputs

end
