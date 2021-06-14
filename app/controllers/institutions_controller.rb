class InstitutionsController < ApplicationController
  # GET /institutions or /institutions.json
  def index
    @institutions = Institution.where query_params
  end

  # GET /institutions/1 or /institutions/1.json
  def show
    @institution = Institution.find params[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def query_params
      params.except(:format).permit(:opeid, :name, :city, :state, :zip, :sector, :duration_of_programs)
    end
end
