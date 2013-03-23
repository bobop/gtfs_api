class CalendarDatesController < ApplicationController
  respond_to :json

  def index
    @calendar_dates = CalendarDate.order(:id)
    if params[:limit].present?
      @calendar_dates = @calendar_dates.limit(params[:limit])
    else
      @calendar_dates = @calendar_dates.limit(200)
    end
    render json: @calendar_dates
  end

  def show
  end
end
