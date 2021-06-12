class ProgramClassification < ApplicationRecord
  has_many :programs, dependent: :destroy
  has_many :institutions, :through => :programs
end
