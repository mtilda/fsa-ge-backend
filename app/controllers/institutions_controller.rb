class InstitutionsController < ApplicationController
  # GET /institutions or /institutions.json
  def index
    @institutions = Institution.where query_params
  end

  # GET /institutions/1 or /institutions/1.json
  def show
    @institution = Institution.find papams[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def query_params
      params.permit(:opeid, :name, :city, :state, :zip, :type)
    end
end
