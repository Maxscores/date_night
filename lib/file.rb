require 'pry'
file_name = "/Users/Max/turing/1module/projects/date_night/lib/movies.txt"

file = File.readlines(file_name)
movies = {}
movies_added = 0
movies = file.map do |line|
  if line[0..1].to_i < 10
    line.prepend("0")
  end
  movie = line.chomp.split(", ")
  if movies.has_key?(movie[0])
    return
  else
    movies_added += 1
    {movie[0]=>movie[1]}
  end
end



# movies_split = movies.map do |movie|
#   movie.split(", ")
# end

puts movies, movies_added
