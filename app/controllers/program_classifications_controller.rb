class ProgramClassificationsController < ApplicationController
  before_action :set_program_classification, only: %i[ show edit update destroy ]

  # GET /program_classifications or /program_classifications.json
  def index
    @program_classifications = ProgramClassification.all
  end

  # GET /program_classifications/1 or /program_classifications/1.json
  def show
  end

  # GET /program_classifications/new
  def new
    @program_classification = ProgramClassification.new
  end

  # GET /program_classifications/1/edit
  def edit
  end

  # POST /program_classifications or /program_classifications.json
  def create
    @program_classification = ProgramClassification.new(program_classification_params)

    respond_to do |format|
      if @program_classification.save
        format.html { redirect_to @program_classification, notice: "Program classification was successfully created." }
        format.json { render :show, status: :created, location: @program_classification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @program_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_classifications/1 or /program_classifications/1.json
  def update
    respond_to do |format|
      if @program_classification.update(program_classification_params)
        format.html { redirect_to @program_classification, notice: "Program classification was successfully updated." }
        format.json { render :show, status: :ok, location: @program_classification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @program_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_classifications/1 or /program_classifications/1.json
  def destroy
    @program_classification.destroy
    respond_to do |format|
      format.html { redirect_to program_classifications_url, notice: "Program classification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_classification
      @program_classification = ProgramClassification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def program_classification_params
      params.require(:program_classification).permit(:code, :name)
    end
end
