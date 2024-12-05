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
  { name: 'Jigglypuff', ability: 'Cute Charm', pokemon_type: 'Fairy', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png' },
  { name: 'Eevee', ability: 'Run Away', pokemon_type: 'Normal', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/133.png' },
  { name: 'Snorlax', ability: 'Immunity', pokemon_type: 'Normal', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png' },
  { name: 'Gengar', ability: 'Cursed Body', pokemon_type: 'Ghost/Poison', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png' },
  { name: 'Dragonite', ability: 'Inner Focus', pokemon_type: 'Dragon/Flying', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png' },
  { name: 'Lucario', ability: 'Steadfast', pokemon_type: 'Fighting/Steel', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/448.png' },
  { name: 'Togepi', ability: 'Hustle', pokemon_type: 'Fairy', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/175.png' },
  { name: 'Lapras', ability: 'Water Absorb', pokemon_type: 'Water/Ice', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/131.png' },
  { name: 'Mewtwo', ability: 'Pressure', pokemon_type: 'Psychic', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png' },
  { name: 'Machamp', ability: 'Guts', pokemon_type: 'Fighting', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/68.png' },
  { name: 'Alakazam', ability: 'Synchronize', pokemon_type: 'Psychic', image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/65.png' }
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
