class CalendarsController < ApplicationController
  respond_to :json

  def index
    @calendars = Calendar.order(:id)
    if params[:limit].present?
      @calendars = @calendars.limit(params[:limit])
    else
      @calendars = @calendars.limit(200)
    end
    render json: @calendars
  end

  def show
  end
end
