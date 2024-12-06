class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons as pokemons_path
  def index
    @pokemons = Pokemon.all
    @users = User.all
    @markers = @pokemons.geocoded.map do |p| {
        lat: p.latitude,
        lng: p.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {pokemon: p}),
        marker_html: render_to_string(partial: "marker")
      }
    end

    # Filter out current user's Pokemons from index page - this is what will be displayed if no search queries
    @users = User.where.not(id: current_user)
    @pokemons = Pokemon.where.not(user_id: current_user)

    if params[:query].present?
      if params[:type_query].present?
        # Searched by name and type
        @pokemons = @pokemons.search_by_name(params[:query]).search_by_type(params[:type_query])
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

    if params[:pokemon][:photo].blank?
      default_image_path = Rails.root.join("app", "assets", "images", "default-pokeball.jpg")
      @pokemon.photo.attach(io: File.open(default_image_path), filename: "default-pokeball.jpg", content_type: "image/jpg")
    end

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
    params.require(:pokemon).permit(:name, :ability, :pokemon_type, :price_per_day, :photo, :address)
  end
end
