class Node
  attr_reader :rating, :movie_title
  attr_accessor :higher_link, :lower_link

  def initialize(rating, movie_title)
    @rating = rating
    @movie_title = movie_title
    @higher_link = nil
    @lower_link = nil
  end

end
