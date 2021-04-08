# Parliamentarian/Australia/Victoria.rb
# Parliamentarian::Australia::Victoria

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

        def legislative_councillors
          @legislative_council ||= fetch(LEGISLATIVE_COUNCIL_URL).collect{|row| self.new(row)}
        end

        def legislative_assemblymen
          @legislative_assembly ||= fetch(LEGISLATIVE_ASSEMBLY_URL).collect{|row| self.new(row)}
        end

      end # class << self

      def initialize(row)
        row.keys.each do |header|
          attr_name = attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
        extract_postcode_from_electorate_office_address
      end

      def surname
        @lastname
      end

      def first_name
        @firstname
      end

      private

      def attr_name(header)
        if header =~ / /
          header.split.collect{|word| word.downcase}.join('_')
        else
          header.downcase
        end
      end

      def extract_postcode_from_electorate_office_address
        self.class.send(:attr_accessor, 'postcode')
        self.postcode = eoaddress.split.last
      end

    end
  end
end

if __FILE__ == $0
  p Parliamentarian::Australia::Victoria.legislative_councillors.first
  p Parliamentarian::Australia::Victoria.legislative_assemblymen.first
  p Parliamentarian::Australia::Victoria.legislative_councillors.count
  p Parliamentarian::Australia::Victoria.legislative_assemblymen.count
end
