class TripsController < ApplicationController
  respond_to :json

  def index
    @trips = Trip.order(:id)
    if params[:limit].present?
      @trips = @trips.limit(params[:limit])
    else
      @trips = @trips.limit(20)
    end
    if params[:route_id].present?
      @trips = @trips.where(route_id: params[:route_id])
    end
    @trips.each.map {|t| t.include_calendar = true} if params[:include_calendar] == 'true'
    # @trips.each.map {|t| t.include_route = true} if params[:include_route] == 'true'

    render json: @trips
  end

  def show
  end
end
