json.partial! "programs/program", program: @program
json.classification do
  json.cip_code @program.program_classification.code
  json.cip_name @program.program_classification.name
end
json.institution do
  json.id @program.institution.id
  json.opeid @program.institution.opeid
  json.name @program.institution.name
  json.city @program.institution.city
  json.state @program.institution.state
  json.zip @program.institution.zip
end
