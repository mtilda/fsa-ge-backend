class ProgramClassificationsController < ApplicationController
  # GET /program_classifications or /program_classifications.json
  def index
    @program_classifications = ProgramClassification.where query_params
  end

  # GET /program_classifications/1 or /program_classifications/1.json
  def show
    @program_classification = ProgramClassification.find params[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def query_params
      params.except(:format).permit(:code, :name)
    end
end
