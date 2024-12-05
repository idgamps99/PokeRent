class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  # GET /pokemons as pokemons_path
  def index
    # Filter out current user's Pokemons from index page - this is what will be displayed if no search queries
    @users = User.where.not(id: current_user)
    @pokemons = Pokemon.where.not(user_id: current_user)

    if params[:query].present?
      if params[:type_query].present?
        # Searched by name and type
        @pokemons = @pokemons.search_by_type(params[:type_query]).search_by_type(params[:type_query])
      else
        # Searched only by name
        @pokemons = @pokemons.search_by_name(params[:query])
      end
    elsif params[:type_query].present?
      # Searched only by type
      @pokemons = @pokemons.search_by_type(params[:type_query])
    end
  end

  # Display pokemons belonging to the user currently logged in
  def my_pokemons
    @pokemons = Pokemon.where(user_id: current_user)
  end

  # GET /pokemons/:id as pokemon_path(pokemon)
  def show
    @pokemon = Pokemon.find(params[:id])
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
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    redirect_to my_pokemons_path
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :ability, :pokemon_type, :price_per_day, :photo)
  end
end
