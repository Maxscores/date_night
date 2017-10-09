require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_it_has_a_rating
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal 61, node.rating
  end

  def test_it_had_a_title
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", node.movie_title
  end

  def test_links_are_false_by_default
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_nil node.higher_link
    assert_nil node.lower_link
  end

end
