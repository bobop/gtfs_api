class TripsController < ApplicationController
  respond_to :json

  def index
    @trips = Trip.order(:id)
    if params[:limit].present?
      @trips = @trips.limit(params[:limit])
    else
      @trips = @trips.limit(200)
    end
    render json: @trips
  end

  def show
  end
end
