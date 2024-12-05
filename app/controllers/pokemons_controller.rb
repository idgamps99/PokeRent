class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons as pokemons_path
  def index
    @pokemons = Pokemon.all
    @users = User.all
  end

  # Display pokemons belonging to the user currently logged in
  def my_pokemons
    @pokemons = Pokemon.where(user_id: current_user)
  end

  # GET /pokemons/:id as pokemon_path(pokemon)
  def show
    @owner = User.find(@pokemon.user_id)
    @booking = Booking.new
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @user = current_user
    @pokemon.user = @user
    if @pokemon.save
      # Changed this so it redirects to my pokemons page
      redirect_to my_pokemons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon.destroy
    redirect_to my_pokemons_path
  end

  def edit
  end

  def update
    if @pokemon.update(pokemon_params)
	    redirect_to pokemon_path(@pokemon), notice: 'Pokémon was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :ability, :pokemon_type, :price_per_day, :photo)
  end
end
