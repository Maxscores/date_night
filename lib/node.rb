class Node
  attr_accessor :rating, :movie_title, :higher_link, :lower_link

  def initialize(rating, movie_title)
    @rating = rating
    @movie_title = movie_title
    @higher_link = nil
    @lower_link = nil
  end

end
