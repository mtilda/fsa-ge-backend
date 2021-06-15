json.extract! program
json.partial! "reports/summary", report: program.reports.order(:year_published).take(1)[0]