class ProgramsController < ApplicationController
  # GET /programs or /programs.json
  def index
    @programs = Program.search(query_params).take(100)
  end

  # GET /programs/1 or /programs/1.json
  def show
    @program = Program.find params[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def query_params
      params.except(:format).permit(
        :institution_id, :program_classification_id, :credential_level, # program params
        :opeid, :institution_name, :city, :state, :zip, :sector, :duration_of_programs, # institution params
        :cip_code, :cip_name  # classification params
      )
    end
end
