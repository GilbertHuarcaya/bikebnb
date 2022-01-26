class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :update, :destroy]
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
    redirect_to rental_path(@rental)
  end

  def destroy
    authorize @rental
    @rental.destroy
    redirect_to rental_path(@rental.bike)
  end

  def update
    authorize @rental
    if @rental.available == true
      @rental.available = false
    else
      @rental.available = true
    end
    @rental.update
    redirect_to rental_path(@rental)
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

  def set_bike
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:comment, :rating)
  end
end
