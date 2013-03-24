class RoutesController < ApplicationController
  respond_to :json

  def index
    # @routes = Route.order(:id)
    # LIMIT RESULTS
    @routes = Route.limit(20) if !params[:limit].present?
    @routes = Route.limit(params[:limit]) if params[:limit].present?

    if params[:name].present?
      @routes = @routes.where("LOWER(route_short_name) LIKE '%#{params[:name].downcase}%' OR LOWER(route_long_name) LIKE '%#{params[:name].downcase}%'")
    end
    if params[:agency_id].present?
      @routes = @routes.where(agency_id: Agency.where(agency_id: params[:agency_id]).first.id)
    end

    @routes.each.map {|r| r.include_trips = true} if params[:include_trips] == 'true'
    
    if params[:distinct].present?
      @routes = @routes.select("DISTINCT ON (route_long_name) routes.*").order("route_long_name DESC")
    end

    if params[:callback].present?
      render json: @routes, callback: params[:callback]
    else
      render json: @routes
    end

    
  end

  def show
  end
end
