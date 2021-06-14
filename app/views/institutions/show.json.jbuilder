json.partial! "institutions/institution", institution: @institution
json.programs @institution.programs do |program|
  json.partial! "programs/program", program: program
  json.classification do
    json.partial! "program_classifications/program_classification", program_classification: program.program_classification
  end
  json.latest_report do
    json.partial! "programs/latest_report", program: program
  end
end
