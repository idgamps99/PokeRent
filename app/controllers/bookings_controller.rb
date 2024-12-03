class BookingsController < ApplicationController
  before_action :set_pokemon

  def new
    @booking = Booking.new
  end

  def create
    @booking = @pokemon.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @pokemon, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
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
