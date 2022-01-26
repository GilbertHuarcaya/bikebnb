class RentalsController < ApplicationController


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

  def edit
    @bike = Bike.find(params[:bike_id])
  end

  def update
    @bike = Bike.find(params[:bike_id])
    @bike.available = false
    @bike.update
    redirect_to bike_path(@bike)
  end
end
