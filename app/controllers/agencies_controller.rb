class AgenciesController < ApplicationController
  respond_to :json

  def index
    @agencies = Agency.order(:id)
    if params[:name].present?
      @agencies = @agencies.where("LOWER(agency_name) LIKE '%#{params[:name].downcase}%'")
    end
    render json: @agencies
  end

  def show
  end
end
