class PokemonsController < ApplicationController

  # GET /pokemons as pokemons_path
  def index
    @pokemons = Pokemon.all
    @users = User.all
  end
end
