class BookingsController < ApplicationController
  before_action :set_pokemon

  def create
    @booking = @pokemon.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      flash[:notice] = "Booking was successfully created for #{@pokemon.name} from #{@booking.booking_start} to #{@booking.booking_end}."
      redirect_to @pokemon
    else
      flash[:alert] = "There was an issue with your booking. Please fix the errors and try again."
      render "pokemons/show", status: :unprocessable_entity
    end
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def booking_params
    params.require(:booking).permit(:booking_start, :booking_end)
  end
end
