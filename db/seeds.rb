# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

json = URI.parse("https://tmdb.lewagon.com/movie/top_rated").read
movies = JSON.parse(json)

puts "Seeding movies..."
index = 0
10.times do
  Movie.create(
    title: movies["results"][index]["title"],
    overview: movies["results"][index]["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movies["results"][index]["poster_path"]}",
    rating: (movies["results"][index]["vote_average"]).round(1))
  index += 1
end
puts "Created 10 movies!"
puts "Seeding movies..."
