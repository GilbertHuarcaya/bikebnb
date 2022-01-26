class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!, except: [:index]
  include Pundit

  def index
    if user_signed_in?
      if current_user.admin
        @bikes = policy_scope(Bike).order(created_at: :desc)
      else
        @bikes = policy_scope(Bike).where.not(user: current_user).order(created_at: :desc)
      end
    else
      @bikes = policy_scope(Bike).where.not(user: current_user).order(created_at: :desc)
    end
  end

  def show
    authorize @bike
  end

  def my_bikes
    @bikes = policy_scope(Bike).where(user: current_user).order(created_at: :desc)
  end

  def new
    @bike = Bike.new
    authorize @bike
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    authorize @bike
    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  def destroy
    authorize @bike
    @bike.destroy
    redirect_to bikes_path
  end

  def edit
    authorize @bike
  end

  def update
    authorize @bike
    @bike.update(bike_params)
    redirect_to bike_path(@bike)
  end

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :my_bikes], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :my_bikes], unless: :skip_pundit?

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
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:description, :model, :price, :photo, :user)
  end
end
