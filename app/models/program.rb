class Program < ApplicationRecord
  has_many :reports
  belongs_to :institution
  belongs_to :program_classification
end
