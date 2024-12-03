class PokemonsController < ApplicationController

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @user = current_user
    @pokemon.user = @user
    if @pokemon.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :ability, :pokemon_type, :price_per_day)
  end
end
