# Parliamentarian.rb
# Parliamentarian

# 20190602
# 0.3.0

require 'open-uri'
require 'SimpleCSV.rbd/SimpleCSV'

module Parliamentarian
  module Australia

    class Victoria

      LEGISLATIVE_COUNCIL_URL = 'https://www.parliament.vic.gov.au/images/members/assemblymembers.csv'
      LEGISLATIVE_ASSEMBLY_URL = 'https://www.parliament.vic.gov.au/images/members/councilmembers.csv'

      class << self

        def fetch(url)
          raw_csv = open(url)
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all
          @all ||= legislative_council + legislative_assembly
        end

        def legislative_council
          @legislative_council ||= fetch(LEGISLATIVE_COUNCIL_URL).collect{|row| self.new(row)}
        end

        def legislative_assembly
          @legislative_assembly ||= fetch(LEGISLATIVE_ASSEMBLY_URL).collect{|row| self.new(row)}
        end

      end # class << self

      def initialize(row)
        row.keys.each do |header|
          attr_name = self.attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
      end

      def attr_name(header)
        if header =~ / /
          header.split.collect{|word| word.capitalize}.join('')
        else
          header
        end
      end

    end

    class Federal

      SENATE_URL = 'https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/allsenel.csv?la=en'
      HOUSE_OF_REPRESENTATIVES_URL = 'https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/SurnameRepsCSV.csv?la=en'

      class << self

        def fetch(url)
          raw_csv = open(url)
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all
          @all ||= senators + house_of_representatives
        end

        def senators
          @senators ||= fetch(SENATE_URL).collect{|row| self.new(row)}
        end
        alias_method :senate, :senators

        def members
          @members ||= fetch(HOUSE_OF_REPRESENTATIVES_URL).collect{|row| self.new(row)}
        end
        alias_method :house_of_representatives, :members

      end # class << self

      def initialize
        row.keys.each do |header|
          attr_name = self.attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
      end

      def attr_name(header)
        if header =~ / /
          header.split.collect{|word| word.capitalize}.join('')
        else
          header
        end
      end

    end

  end
end

if __FILE__ == $0
  require 'fileutils'
  FileUtils.touch('legislative_council.csv')
  csv_file = SimpleCSV.new('legislative_council.csv', mode: 'r+', headers: true)
  parsed_csv = Parliamentarian::Australia::Victoria.fetch(Parliamentarian::Australia::Victoria::LEGISLATIVE_COUNCIL_URL)
  csv_file.columns = parsed_csv.first.keys
  csv_file.rows = parsed_csv
  csv_file.write
end
