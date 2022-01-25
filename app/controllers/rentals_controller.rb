class RentalsController < ApplicationController

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
