class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  def show
    @booking = Booking.new
  end

  def test
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
