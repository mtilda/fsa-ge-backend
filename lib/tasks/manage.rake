# https://github.com/roo-rb/roo
require "roo-xls"

# Ruby on Rails — Importing Data from an Excel File
# https://blog.echobind.com/ruby-on-rails-importing-data-from-an-excel-file-b325b0fcfad6

namespace :manage do
  desc "Scrape data from FSA Gainful Employment spreadsheets"

  # Only run on local from root directory
  task :download do
    %x`curl -o ./lib/assets/FSA-GE-2015.xls https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls`
  end

  task :dump => :environment do
    puts "Deleting all Institutions and Program Classifications"
    puts "(cascade delete Programs and Reports)"
    Institution.delete_all
    ProgramClassification.delete_all
  end

  task :ingest => :environment do
    # https://studentaid.gov/sites/default/files/GE-DMYR-2015-Final-Rates.xls
    puts "Ingesting 2015 FSA Gainful Employment data!"
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

      # INSTITUTION
      
      new_institution_data = {
        opeid: data["Institution Code (six-digit OPEID)"],
        name: data["Institution Name"],
        city: data["City"],
        state: data["State"],
        zip: data["Zip"],
        sector: sector,
        duration_of_programs: duration_of_programs
      }

      institution = Institution.find_by(opeid: data["Institution Code (six-digit OPEID)"])
      if institution.nil?
        puts "NEW ~ Institution: opeid #{data["Institution Code (six-digit OPEID)"]}"
        institution = Institution.new new_institution_data
      else
        puts "FOUND ~ Institution: opeid #{data["Institution Code (six-digit OPEID)"]}"
      end
      
      # PROGRAM CLASSIFICATION

      new_program_classification_data = {
        cip_code: data["CIP Code"].to_i,
        cip_name: data["CIP Name"]
      }

      program_classification = ProgramClassification.find_by(cip_code: new_program_classification_data[:code])
      if program_classification.nil?
        puts "NEW ~ Program Classification: CIP code #{new_program_classification_data[:cip_code]}"
        program_classification = ProgramClassification.new new_program_classification_data
      else
        puts "FOUND ~ Program Classification: CIP code #{new_program_classification_data[:cip_code]}}"
      end

      # PROGRAM

      new_program_data = {
        institution: institution,
        program_classification: program_classification,
        credential_level: data["Credential Level"].to_i,
      }

      program = Program.find_by(institution: institution, program_classification: program_classification)
      if program.nil?
        puts "NEW ~ Program: #{program_classification.cip_name[0, 10]} @ #{institution.name[0, 10]}"
        program = Program.new(new_program_data)
      else
        puts "FOUND ~ Program: #{program_classification.cip_name[0, 10]} @ #{institution.name[0, 10]}"
      end

      # Report

      def parse_pzf str
        if str.nil?
          str
        else
          str.chomp("*")
        end
      end

      def parse_number str
        str.to_f.round(2) unless str == 'NA'
      end

      new_report_data = {
        program: program,
        year_published: 2015,
        official_pzf:                         parse_pzf(        data["Official Program Pass/Zone/Fail"]),
        appeal_status:                                          "",
        annual_de_ratio:                      parse_number(     data["Debt-to-Earnings Annual Rate"]),
        median_annual_debt:                   parse_number(     data["Debt-to-Earnings Annual Rate Numerator"]),
        average_annual_earnings:              parse_number(     data["Debt-to-Earnings Annual Rate Denominator"]),
        annual_pzf:                           parse_pzf(        data["Debt-to-Earnings Annual Rate Pass/Fail/Zone"]),
        discretionary_de_ratio:               parse_number(     data["Debt-to-Earnings Discretionary Income Rate"]),
        average_discretionary_earnings:       parse_number(     data["Debt-to-Earnings Discretionary Income Rate Denominator"]),
        discretionary_pzf:                    parse_pzf(        data["Debt-to-Earnings Discretionary Income Rate Pass/Fail/Zone"]),
        transitional_de_ratio:                parse_number(     data["Debt-to-Earnings Transitional Rate"]),
        median_transitional_debt:             parse_number(     data["Debt-to-Earnings Transitional Rate Numerator"]),
        transitional_pzf:                     parse_pzf(        data["Debt-to-Earnings Transitional Rate Pass/Fail/Zone"]),
        transitional_discretionary_de_ratio:  parse_number(     data["Debt-to-Earnings Transitional Discretionary Income Rate"]),
        transitional_discretionary_pzf:       parse_pzf(        data["Debt-to-Earnings Transitional Discretionary Income Rate Pass/Fail/Zone"]),
        mean_annual_earnings:                 parse_number(     data["Mean  Annual Earnings From SSA"]),
        median_annual_earnings:               parse_number(     data["Median Annual Earnings from SSA"])
      }
      
      report = Report.find_by(program: program, year_published: 2015)
      if report.nil?
        puts "NEW ~ Report: #{program.program_classification.cip_name[0, 10]} @ #{program.institution.name[0, 10]} in 2015"
        report = Report.new new_report_data
      else
        puts "FOUND ~ Report: #{program.program_classification.cip_name[0, 10]} @ #{program.institution.name[0, 10]} in 2015"
      end

      institution.save!
      program_classification.save!
      program.save!
      report.save!
    end
  end
end
