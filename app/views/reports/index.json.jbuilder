json.count @reports.size
json.results @reports do |report|
  json.partial! "reports/report", report: report
  json.program do
    json.partial! "programs/program", program: report.program
    json.program_classification do
      json.partial! "program_classifications/program_classification", program_classification: report.program.program_classification
    end
    json.institution do
      json.partial! "institutions/institution", institution: report.program.institution
    end
  end
end