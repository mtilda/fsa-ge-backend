class Program < ApplicationRecord
  has_many :reports
  belongs_to :institution
  belongs_to :program_classification

  def self.search params
    exact_params = params.slice(:institution_id, :program_classification_id, :credential_level, :cip_code)

    Program
      .joins(:institution)
      .joins(:program_classification)
      .where(exact_params)
      .where("city LIKE ?", "%#{(params[:city] || "").upcase}%")
      .where("state LIKE ?", "%#{(params[:state] || "").upcase}%")
      .where("zip LIKE ?", "%#{(params[:zip] || "").upcase}%")
      .where("name LIKE ?", "%#{(params[:institution_name] || "").upcase}%")
      .where(params[:duration_of_programs] ? "duration_of_programs = '%#{params[:duration_of_programs].upcase}%'" : nil)
      .where("cip_name LIKE ?", "%#{(params[:cip_name] || "").upcase}%")
  end
end
