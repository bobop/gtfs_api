class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.order(:id)
    if params[:limit].present?
      @stops = @stops.limit(params[:limit])
    else
      @stops = @stops.limit(20)
    end
    # if params[:id].present?
    #   @stops = @stops.where(id: params[:id])
    # end
    if params[:stop_id].present?
      @stops = @stops.where(stop_id: params[:stop_id])
    end
    if params[:stop_ids].present?
      @stops = @stops.where(stop_id: params[:stop_ids])
    end

    # STOP TIME PARAMS
    @stops.each.map {|r| r.from_now = true} if params[:from] == 'now'
    @stops.each.map {|r| r.stop_time_limit = params[:stop_time_limit]} if params[:stop_time_limit].present?

    @stops.each.map {|r| r.include_stop_times = true} if params[:include_stop_times] == 'true'

    render json: @stops
  end

  def show
    @stop = Stop.find(params[:id])
    render json: @stop
  end
end
