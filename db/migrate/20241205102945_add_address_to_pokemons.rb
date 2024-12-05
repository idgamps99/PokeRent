class AddAddressToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :address, :string
  end
end
