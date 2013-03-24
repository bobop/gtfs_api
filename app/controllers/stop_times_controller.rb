class StopTimesController < ApplicationController
  respond_to :json

  def index
    @stop_times = StopTime.order(:id)
    if params[:limit].present?
      @stop_times = @stop_times.limit(params[:limit])
    else
      @stop_times = @stop_times.limit(200)
    end
    # params[:trip_ids]=2222,2345,5432,6543
    if params[:trip_ids].present?
      @stop_times = @stop_times.where(trip_id: params[:trip_ids])
    end
    # @stop.each.map {|t| t.include_trip = true} if params[:include_trip] == 'true'

    render json: @stop_times
  end

  def show
  end
end
