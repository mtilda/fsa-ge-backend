# https://github.com/roo-rb/roo
require "roo-xls"

# Ruby on Rails — Importing Data from an Excel File
# https://blog.echobind.com/ruby-on-rails-importing-data-from-an-excel-file-b325b0fcfad6

namespace :scraper do
  desc "Injest data from FSA Gainful Employment spreadsheets"

  task :download do
    %x`curl -o ./lib/assets/FSA-GE-2015.xls https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls`
  end
  
  ######## HEADERS:
  # Institution Code (six-digit OPEID)
  # Institution Name
  # City
  # State
  # Zip
  # Institution Type
    # Private, Not-For-Profit - less than 2 years
    # Private, Not-For-Profit - 2 to 3 years
    # Private, Not-For-Profit - 4 or more years
    # Proprietary  - less than 2 years
    # Proprietary - 2 to 3 years
    # Proprietary - 4 or more years
    # Public - less than 2 years
    # Public - 2 to 3 years
    # Public - 4 or more years
    # Foreign Schools
  # CIP Code
  # CIP Name
  # Credential Level
    # 01 - Undergraduate certificate (includes diploma)
    # 02 - Associate’s degree
    # 03 - Bachelor’s degree
    # 04 - Post baccalaureate certificate
    # 05 - Master’s degree
    # 06 - Doctoral degree
    # 07 - First professional degree, at the graduate level (e.g., M.D., D.D.S, J.D.)
    # 08 - Graduate certificate
  # Official Program Pass/Zone/Fail
    # nil
    # PASS
    # ZONE
    # FAIL
  # Official Appeal Decision
    # nil
    # Abandon
    # Approve
    # NA
    # Deny
  # Appeal Status
    # nil
    # A
  # Debt-to-Earnings Annual Rate
  # Debt-to-Earnings Annual Rate Numerator
  # Debt-to-Earnings Annual Rate Denominator
  # Debt-to-Earnings Annual Rate Pass/Fail/Zone
  # Debt-to-Earnings Discretionary Income Rate
  # Debt-to-Earnings Discretionary Income Rate Numerator
  # Debt-to-Earnings Discretionary Income Rate Denominator
  # Debt-to-Earnings Discretionary Income Rate Pass/Fail/Zone
  # Debt-to-Earnings Transitional Rate
  # Debt-to-Earnings Transitional Rate Numerator
  # Debt-to-Earnings Transitional Rate Denominator
  # Debt-to-Earnings Transitional Rate Pass/Fail/Zone
  # Debt-to-Earnings Transitional Discretionary Income Rate
  # Debt-to-Earnings Transitional Discretionary Income Rate Numerator
  # Debt-to-Earnings Transitional Discretionary Income Rate Denominator
  # Debt-to-Earnings Transitional Discretionary Income Rate Pass/Fail/Zone
  # Mean  Annual Earnings From SSA
  # Median Annual Earnings from SSA

  task :injest, [:uri] do |t, args|
    # https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls
    puts "Scraping 2015 FSA Gainful Employment data!"
    data = Roo::Spreadsheet.open("./lib/assets/FSA-GE-2015.xls")

    headers = data.row(1)
    puts headers
    
  end
end
