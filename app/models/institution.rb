class Institution < ApplicationRecord
  has_many :programs, dependent: :destroy
  has_many :program_classifications, :through => :programs
end
