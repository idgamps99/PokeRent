require 'open-uri'

# Clear existing data
User.destroy_all
Pokemon.destroy_all

# Sample Pokémon data with image URLs
pokemon_data = [
  { name: 'Pikachu', ability: 'Static', pokemon_type: 'Electric', price_per_day: 10.5, image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png', address: 'Paris, France', latitude: 48.8566, longitude: 2.3522 },
  { name: 'Charmander', ability: 'Blaze', pokemon_type: 'Fire', price_per_day: 15.0, image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png', address: 'London, England', latitude: 51.509146, longitude: 0.165894 },
  { name: 'Bulbasaur', ability: 'Overgrow', pokemon_type: 'Grass', price_per_day: 12.0, image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png', address: 'Brussels, Belgium', latitude: 50.854966, longitude: 4.362092 },
  { name: 'Squirtle', ability: 'Torrent', pokemon_type: 'Water', price_per_day: 11.0, image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png', address: 'Thames, London', latitude: 51.500357, longitude: 0.121522 },
  { name: 'Jigglypuff', ability: 'Cute Charm', pokemon_type: 'Fairy', price_per_day: 9.0, image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png', address: 'Luxembourg, Luxembourg', latitude: 49.613610, longitude: 6.123213 }
]
# Create users
5.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    username: "User#{i + 1}",
    first_name: "FirstName#{i + 1}",
    last_name: "LastName#{i + 1}",
    password: 'password'
  )
  # Assign 5 Pokémon to each user
  pokemon_data.each do |pokemon|
    new_pokemon = user.pokemons.create!(
      name: pokemon[:name],
      ability: pokemon[:ability],
      pokemon_type: pokemon[:pokemon_type],
      price_per_day: pokemon[:price_per_day],
      address: pokemon[:address],
      latitude: pokemon[:latitude],
      longitude: pokemon[:longitude]
    )
    # Attach the Pokémon image using Active Storage
    file = URI.open(pokemon[:image_url])
    new_pokemon.photo.attach(io: file, filename: "#{pokemon[:name].downcase}.png", content_type: 'image/png')
  end
end

puts "Seed data created successfully!"
