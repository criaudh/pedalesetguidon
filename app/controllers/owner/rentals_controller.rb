class Owner::RentalsController < ApplicationController
  before_action :set_owner_rental, only: %i[accept decline]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @owner_rentals = Rental.includes(:bike).where(bike: { user: current_user })
  end

  def accept
    @owner_rental = Rental.find(params[:id])
    @owner_rental.status = "validated"
    @owner_rental.save

    redirect_to owner_rentals_path
  end

  def refuse
    @owner_rental = Rental.find(params[:id])
    @owner_rental.status = "refused"
    @owner_rental.save

    redirect_to owner_rentals_path
  end

  private

  def set_owner_rental
    @owner_rental = Rental.find(params[:id])
  end
end
