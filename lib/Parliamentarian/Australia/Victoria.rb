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

        def fetch(csv_file_location)
          raw_csv = if ['http', 'https'].include?(URI.parse(csv_file_location).scheme)
            URI.open(csv_file_location)
          else
            File.read(csv_file_location)
          end
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all(legislative_councillors_csv_file_location = nil, legislative_assemblymen_csv_file_location = nil)
          @all ||= (legislative_councillors(legislative_councillors_csv_file_location) + legislative_assemblymen(legislative_assemblymen_csv_file_location)).flatten
        end

        def legislative_councillors(csv_file_location = nil)
          @legislative_council ||= (
            csv_file_location = csv_file_location || LEGISLATIVE_COUNCIL_URL
            fetch(csv_file_location).collect{|row| self.new(row)}
          )
        end

        def legislative_assemblymen(csv_file_location = nil)
          @legislative_assembly ||= (
            csv_file_location = csv_file_location || LEGISLATIVE_ASSEMBLY_URL
            fetch(csv_file_location).collect{|row| self.new(row)}
          )
        end

      end # class << self

      def initialize(row)
        row.keys.each do |header|
          attr_name = self.attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
        extract_postcode_from_electorate_office_address
      end

      # For consistency with Australia::Federal and vice-versa...
      def firstname; preferredname; end
      def first_name; preferredname; end
      def surname; lastname; end
      def last_name; lastname; end

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
