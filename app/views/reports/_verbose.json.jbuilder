json.extract! report, :id, :year_published, :official_pzf, :appeal_status
json.partial! "reports/summary", report: report
json.program do
  json.partial! "programs/program", program: report.program
  json.program_classification do
    json.partial! "program_classifications/program_classification", program_classification: report.program.program_classification
  end
  json.institution do
    json.partial! "institutions/institution", institution: report.program.institution
  end
end
json.discretionary do
  json.label "Debt-to-Earnings Discretionary Income Rate"
  json.description "The gainful employment measure of the ratio of the median annual loan payment amount incurred by students, for attendance in the GE program, who completed the GE Program compared to those same former students’ average discretionary annual income. Discretionary income is calculated as the higher of the mean or median annual earnings less 150% of the Poverty Guidelines for a one-person family in the contiguous United States."
  json.ratio report.discretionary_de_ratio
  json.debt_numerator report.median_annual_debt  # duplicate
  json.earnings_denominator report.average_discretionary_earnings
  json.pzf report.discretionary_pzf
end
json.transitional do
  json.label "Debt-to-Earnings Transitional Annual Rate"
  json.description "The Debt-to-Earnings Transitional Annual Rate replaces the Debt-to-Earnings Annual Rate’s median annual loan payment for the standard cohort with a median annual loan payment for a transitional cohort – students who completed the program during the calculation year. Transitional rates are only calculated if the GE program did not pass the Debt-to-Earnings Annual Rate or the Debt-to-Earnings Discretionary Income Rate and there are at least 10 completers in the transitional cohort."
  json.ratio report.transitional_de_ratio
  json.debt_numerator report.median_transitional_debt
  json.earnings_denominator report.average_discretionary_earnings  # duplicate
  json.pzf report.transitional_pzf
end
json.transitional_discretionary do
  json.label "Debt-to-Earnings Transitional Discretionary Income Rate"
  json.description "The Debt-to-Earnings Transitional Discretionary Income Rate replaces the Debt-to-Earnings Discretionary Income Rate’s median annual loan payment for the standard cohort with a median annual loan payment for a transitional cohort – students who completed the program during the calculation year. Transitional rates are only calculated if the program did not pass the Debt-to-Earnings Annual Rate or the Debt-to-Earnings Discretionary Income Rate and there are at least 10 completers in the transitional cohort."
  json.ratio report.transitional_discretionary_de_ratio
  json.debt_numerator report.median_transitional_debt  # duplicate
  json.earnings_denominator report.average_discretionary_earnings  # duplicate
  json.pzf report.transitional_discretionary_pzf
end
json.ssa do
  json.label "SSA - Annual Earnings"
  json.description "The mean and median annual earnings of the standard completer cohort, obtained from the Social Security Administration’s Master Earnings File. These higher of these values is used to calculate Average Annual/Transitional Earnings."
  json.mean_annual_earnings report.mean_annual_earnings
  json.median_annual_earnings report.median_annual_earnings
end