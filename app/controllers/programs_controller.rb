class ProgramsController < ApplicationController
  # GET /programs or /programs.json
  def index
    @programs = Program.where query_params
  end

  # GET /programs/1 or /programs/1.json
  def show
    @program = Program.find papams[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def query_params
      params.permit(:institution_id, :program_classification_id, :credential_level)
    end
end
