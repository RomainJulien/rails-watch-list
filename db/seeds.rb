# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def fetch_top_rated_movies
  url = "https://tmdb.lewagon.com/movie/top_rated"
  response = URI.open(url).read
  movies = JSON.parse(response)['results']

  movies
end

Movie.destroy_all

fetch_top_rated_movies.each do |movie_data|

  poster_url = movie_data['poster_path'] ? "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}" : nil

  begin
    Movie.create!(
      title: movie_data['title'],
      overview: movie_data['overview'],
      poster_url: poster_url,
      rating: movie_data['vote_average'] || 0.0
    )
  rescue => e
    puts "Erreur lors de la création du film #{movie_data['title']}: #{e.message}"
  end
end

puts 'Movies have been seeded successfully!'
