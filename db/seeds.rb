require 'open-uri'

# Clear existing data
User.destroy_all
Pokemon.destroy_all

# Sample Pokémon data with image URLs
pokemon_data = [
  { name: 'Pikachu', ability: 'Static', pokemon_type: 'Electric', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png', address: 'Paris, France', latitude: 48.8566, longitude: 2.3522 },
  { name: 'Charmander', ability: 'Blaze', pokemon_type: 'Fire', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png', address: 'London, England', latitude: 51.509146, longitude: -0.165894 },
  { name: 'Bulbasaur', ability: 'Overgrow', pokemon_type: 'Grass', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png', address: 'Brussels, Belgium', latitude: 50.854966, longitude: 4.362092 },
  { name: 'Squirtle', ability: 'Torrent', pokemon_type: 'Water', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png', address: 'Thames, London', latitude: 51.500357, longitude: -0.121522 },
  { name: 'Jigglypuff', ability: 'Cute Charm', pokemon_type: 'Fairy', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png', address: 'Luxembourg, Luxembourg', latitude: 49.613610, longitude: 6.123213 },
  { name: 'Eevee', ability: 'Run Away', pokemon_type: 'Normal', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/133.png', address: 'Tokyo, Japan', latitude: 35.689487, longitude: 139.691711 },
  { name: 'Snorlax', ability: 'Immunity', pokemon_type: 'Normal', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png', address: 'New York City, USA', latitude: 40.712776, longitude: -74.005974 },
  { name: 'Gengar', ability: 'Cursed Body', pokemon_type: 'Ghost/Poison', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png', address: 'Edinburgh, Scotland', latitude: 55.953251, longitude: -3.188267 },
  { name: 'Dragonite', ability: 'Inner Focus', pokemon_type: 'Dragon/Flying', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png', address: 'Sydney, Australia', latitude: -33.868820, longitude: 151.209290 },
  { name: 'Lucario', ability: 'Steadfast', pokemon_type: 'Fighting/Steel', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/448.png', address: 'Berlin, Germany', latitude: 52.520008, longitude: 13.404954 },
  { name: 'Togepi', ability: 'Hustle', pokemon_type: 'Fairy', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/175.png', address: 'Rome, Italy', latitude: 41.902782, longitude: 12.496366 },
  { name: 'Lapras', ability: 'Water Absorb', pokemon_type: 'Water/Ice', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/131.png', address: 'Cape Town, South Africa', latitude: -33.924870, longitude: 18.424055 },
  { name: 'Mewtwo', ability: 'Pressure', pokemon_type: 'Psychic', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png', address: 'Beijing, China', latitude: 39.904202, longitude: 116.407394 },
  { name: 'Machamp', ability: 'Guts', pokemon_type: 'Fighting', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/68.png', address: 'Rio de Janeiro, Brazil', latitude: -22.906847, longitude: -43.172897 },
  { name: 'Alakazam', ability: 'Synchronize', pokemon_type: 'Psychic', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/65.png', address: 'San Francisco, USA', latitude: 37.774929, longitude: -122.419416 }
]

# Create users
20.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.create!(
    email: Faker::Internet.email(name: first_name),
    username: "User#{i + 1}",
    first_name: first_name,
    last_name: last_name,
    password: 'password',
  )
  # Assign random number of Pokémon to each user
  randomised_data = pokemon_data.shuffle.first(rand(3..10))
  randomised_data.each do |pokemon|
    new_pokemon = user.pokemons.create!(
      name: pokemon[:name],
      ability: pokemon[:ability],
      pokemon_type: pokemon[:pokemon_type],
      price_per_day: rand(1..5),
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
