# clean the seed each time before i run it
# rails db:seed:replant
# if Rails.env.development?
#   puts "Destroying all data.."
#   User.destroy_all
#   Pokemon.destroy_all
# end

puts "Starting seeds.."
pokemon_data = [
  { name: "Pikachu", ability: "Static", pokemon_type: "Electric", price_per_day: 12.5 },
  { name: "Charmander", ability: "Blaze", pokemon_type: "Fire", price_per_day: 15.0 },
  { name: "Bulbasaur", ability: "Overgrow", pokemon_type: "Grass/Poison", price_per_day: 10.0 },
  { name: "Squirtle", ability: "Torrent", pokemon_type: "Water", price_per_day: 12.0 },
  { name: "Eevee", ability: "Adaptability", pokemon_type: "Normal", price_per_day: 14.0 }
]

# Create 5 users, each with 5 Pokémon
5.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    password: "password",
    username: "user#{i + 1}",
    first_name: "FirstName#{i + 1}",
    last_name: "LastName#{i + 1}"
  )

  # Assign 5 Pokémon to each user
  pokemon_data.each do |poke|
    user.pokemons.create!(
      name: poke[:name],
      ability: poke[:ability],
      pokemon_type: poke[:pokemon_type],
      price_per_day: poke[:price_per_day]
    )
  end
end

puts "Seeded 5 users with 5 Pokémon each."
