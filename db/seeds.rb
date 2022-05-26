# This file should contain all the record creation needed to  the database with its default values.
# The data can then be loaded with the bin/rails db: command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated" #API url
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)

create_movies = movie["results"]

Movie.destroy_all
puts 'Deleting Database.'

puts 'Creating movies.'

create_movies.each do |m|
  movie = Movie.create(
    title: m['title'],
    overview: m['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{m['poster_path']}",
    rating: m['vote_average']
  )
  puts movie.title
end

puts 'Movies generated!'
