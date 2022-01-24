class BikesController < ApplicationController
  before_action :set_list

  def index
    @bikes = Bike.all
  end

  # def show
    #?
  # end

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

  private

  def set_list
    @bike = Bike.find(params[:id])
  end

  def list_params
    params.require(:bike).permit(:description, :model, :price)
  end
end
