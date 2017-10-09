class Crawler
  def include(match_rating, start_rating)
    conditions = [condition_1 = true,
                  condition_2 = false,
                  condition_3 = 3,
                  condition_4 = "four",
                  condition_5 = "12345".length
                  ]
    crawler(conditions, match_rating, start_rating)
  end

  def crawler(conditions, match_rating, start_rating, tree_depth=0)

    if start_rating == match_rating
      condition_1
    elsif start_rating < match_rating && start_node.higher_link.nil?
      condition_2
    elsif start_rating > match_rating && start_node.lower_link.nil?
      condition_3
    elsif start_rating < match_rating
      condition_4
    elsif start_rating > match_rating
      condition_5
    end
  end

  # include_blocks = [true,
  #                   false,
  #                   false,
  #                   include?(higher),
  #                   include?(lower)
  #                   ]
  #
  # depth_of_blocks = [tree_depth,
  #                    nil,
  #                    nil,
  #                    tree_depth += 1 && crawler,
  #                    tree_depth += 1 && crawler
  #                    ]
  #
  # find_parent_node_blocks = [nil,
  #                            start_node,
  #                            start_node,
  #                            find_parent_node(higher),
  #                            find_parent_node(lower)
  #                            ]
end
