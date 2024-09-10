# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Seed the RottenPotatoes DB with some movies.
more_movies = [
  { title: 'The Matrix', rating: 'R', release_date: '1999-Mar-31' },
  { title: 'The Godfather', rating: 'PG-18', release_date: '1972-Mar-24' },
  { title: 'Pulp Fiction', rating: 'R', release_date: '1994-Oct-14' },
  { title: 'The Dark Knight', rating: 'PG-18', release_date: '2008-July-18' },
  { title: 'Inception', rating: 'PG-13', release_date: '2010-July-16' },
  { title: 'Fight Club', rating: 'R', release_date: '1999-Oct-15' }
]

more_movies.each do |movie|
  Movie.create!(movie)
end
