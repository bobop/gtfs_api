class AgenciesController < ApplicationController
  respond_to :json

  def index
    @agencies = Agency.order(:id)
    if params[:name].present?
      @agencies = @agencies.where("LOWER(agency_name) LIKE '%#{params[:name].downcase}%'")
    end

    if params[:callback].present?
      render json: @agencies, callback: params[:callback]
    else
      render json: @agencies
    end
  end

  def show
  end
end
