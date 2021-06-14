json.programs @programs do |program|
  json.partial! "programs/program", program: program
  json.classification do
    json.partial! "program_classifications/program_classification", program_classification: program.program_classification
  end
  json.institution do
    json.partial! "institutions/institution", institution: program.institution
  end
end
