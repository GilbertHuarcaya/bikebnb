class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :update, :destroy, :complete, :edit]
  before_action :authenticate_user!
  include Pundit

  def bike_rentals
    @rentals = policy_scope(Rental).where(bike: params[:id]).order(created_at: :desc)
  end

  def my_rentals
    @rentals = policy_scope(Rental).where(user: current_user).order(created_at: :desc)
  end

  def show
    authorize @rental
  end

  def create
    @rental = Rental.new
    @bike = Bike.find(params[:bike_id])
    @rental.bike = @bike
    @rental.user = current_user
    authorize @rental
    @rental.save
    @bike.update({ available: false })
    redirect_to my_rentals_rentals_path
  end

  def destroy
    @bike = Bike.find(@rental[:bike_id])
    authorize @rental
    @bike.update({ available: true })
    @rental.destroy
    redirect_to my_rentals_rentals_path
  end

  def edit
    authorize @rental
  end

  def update
    @bike = Bike.find(@rental[:bike_id])
    authorize @rental
    @bike.update({ available: true })
    @rental.update({ declined: true })
    @rental.update(rental_params)
    if current_user != @bike.user
      redirect_to my_rentals_rentals_path
    else
    redirect_to bike_path(@bike)
    end
  end

  def complete
    @bike = Bike.find(@rental[:bike_id])
    authorize @rental
    @bike.update({ available: true })
    @rental.update({ completed: true })
    redirect_to my_bikes_bikes_path
  end

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:bike_rentals, :my_rentals], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:bike_rentals, :my_rentals], unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.permit(:declined_comment)
  end
end
