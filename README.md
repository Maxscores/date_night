# date_night
This was my first project at Turing. The task was to build a binary tree data structure from scratch with functions that allowed us to traverse the tree, add data, remove data, and provide information about the tree. The assignment can be found here: http://backend.turing.io/module1/projects/date_night

## Setup
To download the project and run the full test suite was written for the project.

```
git clone https://github.com/Maxscores/date_night.git
cd date_night
ruby tests/tree_test.rb
ruby tests/node_test.rb
```

To interact with the project in terminal run (inside date_night directory)
```
irb
require './lib/tree.rb'
tree = Tree.new
```

These instance methods can be called on the Tree object:

### `insert`

The `insert` method adds a new node with the passed-in data. Each node is comprised of a score and a movie title. It returns the depth of the new node in the tree.

```ruby
tree.insert(61, "Bill & Ted's Excellent Adventure")
# => 0
tree.insert(16, "Johnny English")
# => 1
tree.insert(92, "Sharknado 3")
# => 1
tree.insert(50, "Hannibal Buress: Animal Furnace")
# => 2
```

### `include?`

Verify/reject the presence of a score in the tree:

```ruby
tree.include?(16)
# => true
tree.include?(72)
# => false
```

### `depth_of`

Reports the depth of the tree where a score appears. Return nil if the score does not exist:

```ruby
tree.depth_of(92)
# => 1
tree.depth_of(50)
# => 2
```

### `max`

Which movie has the highest score in the list? What is it's score?

```ruby
tree.max
# => {"Sharknado 3"=>92}
```

### `min`

Which movie has the lowest score in the list? What is it's score?

```ruby
tree.min
# => {"Johnny English"=>16}
```

### `sort`

Return an array of all the movies and scores in sorted ascending order. Return them as an array of hashes.

```ruby
tree.sort
# => [{"Johnny English"=>16},
#   {"Hannibal Buress: Animal Furnace"=>50},
#   {"Bill & Ted's Excellent Adventure"=>61},
#  {"Sharknado 3"=>92}]
```

### `load`

Assuming we have a file named `movies.txt` with one score/movie pair per line:

```ruby
tree.load_file('./lib/movies.txt')
# => 100
```

### `health`

Report on the health of the tree by summarizing the number of child nodes (nodes beneath each node) at a given depth. Where the return value is an `Array` with one nested array per node at that level. The nested array is:

```
[Score of the node, Total number of child nodes, Percentage of all the nodes that are this node or it's children]
```


```ruby
tree.insert(98, "Animals United")
tree.insert(58, "Armageddon")
tree.insert(36, "Bill & Ted's Bogus Journey")
tree.insert(93, "Bill & Ted's Excellent Adventure")
tree.insert(86, "Charlie's Angels")
tree.insert(38, "Charlie's Country")
tree.insert(69, "Collateral Damage")
tree.health(0)
=> [[98, 7, 100]]
tree.health(1)
=> [[58, 6, 85]]
tree.health(2)
=> [[36, 2, 28], [93, 3, 42]]
```

When the percentages of two nodes at the same level are dramatically different, like `28` and `42` above, then we know that this tree is starting to become unbalanced.


### `leaves`

A leaf is a node that has no left or right value. How many leaf nodes are on the tree?

```ruby
tree.leaves
# => 2
```

### `height`

What is the height (aka the maximum depth) of the tree?


```ruby
tree.height
# => 3
```
