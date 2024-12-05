require 'open-uri'

# Clear existing data
User.destroy_all
Pokemon.destroy_all

# Sample Pokémon data with image URLs
pokemon_data = [
  { name: 'Pikachu', ability: 'Static', pokemon_type: 'Electric', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png' },
  { name: 'Charmander', ability: 'Blaze', pokemon_type: 'Fire', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png' },
  { name: 'Bulbasaur', ability: 'Overgrow', pokemon_type: 'Grass', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png' },
  { name: 'Squirtle', ability: 'Torrent', pokemon_type: 'Water', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png' },
  { name: 'Jigglypuff', ability: 'Cute Charm', pokemon_type: 'Fairy', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png' }
]
# Create users
5.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.create!(
    email: Faker::Internet.email(name: first_name),
    username: "User#{i + 1}",
    first_name: first_name,
    last_name: last_name,
    password: 'password'
  )
  # Assign 5 Pokémon to each user
  pokemon_data.each do |pokemon|
    new_pokemon = user.pokemons.create!(
      name: pokemon[:name],
      ability: pokemon[:ability],
      pokemon_type: pokemon[:pokemon_type],
      price_per_day: rand(8..34),
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
