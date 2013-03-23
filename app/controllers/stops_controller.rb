class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.order(:id)
    if params[:limit].present?
      @stops = @stops.limit(params[:limit])
    else
      @stops = @stops.limit(200)
    end
    render json: @stops
  end

  def show
  end
end
