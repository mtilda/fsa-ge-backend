json.count @institutions.size
json.results @institutions do |institution|
  json.partial! "institutions/institution", institution: institution
end
