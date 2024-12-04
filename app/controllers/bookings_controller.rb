class BookingsController < ApplicationController
  before_action :set_pokemon, only: [:create]

  def index
    @my_bookings = current_user.bookings.includes(:pokemon)
    @received_bookings = current_user.received_bookings.includes(:pokemon).where(status: "pending")
    @accepted_bookings = current_user.received_bookings.includes(:pokemon).where(status: "accepted")
  end

  def new
    @booking = Booking.new
  end

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

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    @booking.save
    redirect_to bookings_path
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.status = "rejected"
    @booking.save
    redirect_to bookings_path
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def booking_params
    params.require(:booking).permit(:booking_start, :booking_end)
  end
end
