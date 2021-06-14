json.extract! report, :id, :year_published, :official_pzf, :appeal_status
json.currency_units "US"
json.annual do
  json.label "Debt-to-Earnings Annual Rate"
  json.description "The gainful employment measure of the ratio of the median annual loan payment amount, incurred by students, for attendance in the GE program, who completed the GE Program in the cohort period compared to those same former students’ average annual earnings."
  json.de_ratio report.annual_de_ratio
  json.debt report.median_annual_debt
  json.earnings report.average_annual_earnings
end
