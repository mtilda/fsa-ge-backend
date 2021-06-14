json.partial! "program_classifications/program_classification", program_classification: @program_classification
json.programs @program_classification.programs do |program|
  json.partial! "programs/program", program: program
  json.institution do
    json.partial! "institutions/institution", institution: program.institution
  end
end
