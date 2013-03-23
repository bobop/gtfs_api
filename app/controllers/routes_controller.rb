class RoutesController < ApplicationController
  respond_to :json

  def index
    @routes = Route.order(:id)
    if params[:name].present?
      @routes = @routes.where("LOWER(route_short_name) LIKE '%#{params[:name].downcase}%' OR LOWER(route_long_name) LIKE '%#{params[:name].downcase}%'")
    end
    if params[:agency_id].present?
      @routes = @routes.where(agency_id: Agency.where(agency_id: params[:agency_id]).first.id)
    end
    if params[:limit].present?
      @routes = @routes.limit(params[:limit])
    else
      @routes = @routes.limit(200)
    end
    render json: @routes
  end

  def show
  end
end
