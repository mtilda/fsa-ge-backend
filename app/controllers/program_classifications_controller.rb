class ProgramClassificationsController < ApplicationController
  # GET /program_classifications or /program_classifications.json
  def index
    @program_classifications = ProgramClassification.all
  end

  # GET /program_classifications/1 or /program_classifications/1.json
  def show
    @program_classification = ProgramClassification.where params[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def program_classification_params
      params.require(:program_classification).permit(:code, :name)
    end
end
