class ProgramsController < ApplicationController
  # GET /programs or /programs.json
  def index
    validate_params

    @programs = Program
      .joins(:institution)
      .where(@program_query)
      .where("city LIKE ?", "%#{params[:city].upcase}%")
      .where("state LIKE ?", "%#{params[:state].upcase}%")
      .where("zip LIKE ?", "%#{params[:zip].upcase}%")
      .where("name LIKE ?", "%#{params[:institution_name].upcase}%")
      .where(params[:duration_of_programs] ? "duration_of_programs = '%#{params[:duration_of_programs].upcase}%'" : nil)
      .take(100)
  end

  # GET /programs/1 or /programs/1.json
  def show
    @program = Program.find params[:id]
  end

  private
    # Only allow a list of trusted parameters through.
    def validate_params
      @valid_params = params.except(:format).permit(
        :institution_id, :program_classification_id, :credential_level, # program fields
        :opeid, :institution_name, :city, :state, :zip, :sector, :duration_of_programs, # institution fields
        # :classification_name
      )

      @program_query = @valid_params.slice(:institution_id, :program_classification_id, :credential_level)
      
      @institution_query = {}
      @institution_query[:duration_of_programs] = @valid_params[:duration_of_programs] if @valid_params[:duration_of_programs]
    end
end
