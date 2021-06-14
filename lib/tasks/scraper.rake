# https://github.com/roo-rb/roo
require "roo-xls"

# Ruby on Rails — Importing Data from an Excel File
# https://blog.echobind.com/ruby-on-rails-importing-data-from-an-excel-file-b325b0fcfad6

namespace :scraper do
  desc "Scrape data from FSA Gainful Employment spreadsheets"

  # Only run on local from root directory
  # task :download do
  #   %x`curl -o ./lib/assets/FSA-GE-2015.xls https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls`
  # end

  task :injest, [:uri] => :environment do |t, args|
    # https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls
    puts "Injesting 2015 FSA Gainful Employment data!"
    data = Roo::Spreadsheet.open("./lib/assets/FSA-GE-2015.xls")
    puts "Successfully opened file at './lib/assets/FSA-GE-2015.xls'"

    headers = data.row(1)
    headers.each_with_index do |header, idx|
      puts "HEADER #{idx.to_s.rjust(2, '0')} ~ '#{header}'\n"
    end

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header
      # create hash from headers and cells
      data = Hash[[headers, row].transpose]

      # INSTITUTION

      institution = Institution.find_by(opeid: data["Institution Code (six-digit OPEID)"])
      
      if institution.nil?
        puts "NEW ~ Institution: opeid #{data["Institution Code (six-digit OPEID)"]}"

        # MATCH SECTOR
        known_sectors = [
          "PRIVATE, NOT-FOR-PROFIT",
          "PROPRIETARY",
          "PUBLIC",
          "FOREIGN SCHOOLS"
        ]
        
        sector = ""
        known_sectors.each do |known|
          if data["Institution Type"].include? known
            sector = known
            break
          end
        end

        # MATCH DURATION
        known_durations = {
          :"LESS THAN 2" => "<2",
          :"2 TO 3" => "2-3",
          :"4" => "4+"
        }

        duration_of_programs = ""
        known_durations.each do |key, value|
          if data["Institution Type"].include? key.to_s
            duration_of_programs = value
            break
          end
        end

        institution = Institution.new(
          opeid: data["Institution Code (six-digit OPEID)"],
          name: data["Institution Name"],
          city: data["City"],
          state: data["State"],
          zip: data["Zip"],
          sector: sector,
          duration_of_programs: duration_of_programs
        )
      else
        puts "FOUND ~ Institution: opeid #{data["Institution Code (six-digit OPEID)"]}"
      end
      
      # PROGRAM CLASSIFICATION

      program_classification = ProgramClassification.find_by(code: data["CIP CODE"])

      if program_classification.nil?
        puts "NEW ~ Program Classification: CIP code #{data["CIP CODE"]}"

        program_classification = ProgramClassification.new(
          code: data["CIP Code"],
          name: data["CIP Name"]
        )
      else
        puts "FOUND ~ Program Classification: CIP code #{data["CIP CODE"]}}"
      end

      # PROGRAM

      program = Program.find_by(institution: institution, program_classification: program_classification)

      if program.nil?
        puts "NEW ~ Program: #{program_classification.name} @ #{institution.name}"

        program = Program.new(
          institution: institution,
          program_classification: program_classification,
          credential_level: data["CIP Name"].to_i,
        )
      else
        puts "FOUND ~ Program: #{program_classification.name} @ #{institution.name}"
      end

      # Report

      report = Report.find_by(program: program, year_published: 2015)

      if report.nil?
        puts "NEW ~ Report: #{program.program_classification.name} @ #{program.institution.name} in 2015"

        Report.new(
          program: program,
          year_published: 2015,
          official_pzf: data["Official Program Pass/Zone/Fail"],
          appeal_status: "",
          annual_de_ratio: data["Debt-to-Earnings Annual Rate"].to_f,
          median_annual_debt: data["Debt-to-Earnings Annual Rate Numerator"].to_f,
          average_annual_earnings: data["Debt-to-Earnings Annual Rate Denominator"].to_f,
          annual_pzf: data["Debt-to-Earnings Annual Rate Pass/Fail/Zone"].chomp("*"),
          discretionary_de_ratio: data["Debt-to-Earnings Discretionary Income Rate"].to_f,
          average_discretionary_earnings: data["Debt-to-Earnings Discretionary Income Rate Denominator"].to_f,
          discretionary_pzf: data["Debt-to-Earnings Discretionary Income Rate Pass/Fail/Zone"].chomp("*"),
          transitional_de_ratio: data["Debt-to-Earnings Transitional Rate"].to_f,
          median_transitional_debt: data["Debt-to-Earnings Transitional Rate Numerator"].to_f,
          transitional_pzf: data["Debt-to-Earnings Transitional Rate Pass/Fail/Zone"].chomp("*"),
          transitional_discretionary_de_ratio: data["Debt-to-Earnings Transitional Discretionary Income Rate"].to_f,
          transitional_discretionary_pzf: data["Transitional Discretionary Income Rate Pass/Fail/Zone"].chomp("*"),
          mean_annual_earnings: data["Mean  Annual Earnings From SSA"].to_f,
          median_annual_earnings: data["Median Annual Earnings from SSA"].to_f
        )
      else
        puts "FOUND ~ Report: #{program.program_classification.name} @ #{program.institution.name} in 2015"
      end
    end
  end
end
