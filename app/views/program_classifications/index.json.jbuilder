json.count @program_classifications.size
json.results @program_classifications do |program_classification|
  json.partial! "program_classifications/program_classification", program_classification: program_classification
  json.program_count program_classification.programs.size
  json.institution_count program_classification.institutions.size
end