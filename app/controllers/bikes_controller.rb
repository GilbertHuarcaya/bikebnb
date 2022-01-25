class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :update, :destroy, :edit]

  def index
    @bikes = Bike.all
  end

  def show
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  def destroy
    @bike.destroy
    redirect_to bikes_path
  end

  def edit
  end

  def update
    @bike.update(bike_params)
    redirect_to bike_path(@bike)
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:description, :model, :price, :photo)
  end
end
