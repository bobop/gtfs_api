class TripsController < ApplicationController
  respond_to :json

  def index
    @trips = Trip.order(:id)
    if params[:limit].present?
      @trips = @trips.limit(params[:limit])
    else
      @trips = @trips.limit(20)
    end
    @trips.each.map {|t| t.include_calendar = true} if params[:include_calendar] == 'true'
    logger.info "--- @trips = #{@trips.inspect}"

    render json: @trips
  end

  def show
  end
end
