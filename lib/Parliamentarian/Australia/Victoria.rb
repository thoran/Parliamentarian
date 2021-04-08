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
          raw_csv = URI.open(url)
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all
          @all ||= legislative_councillors + legislative_assemblymen
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
          attr_name = self.attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
        extract_postcode_from_electorate_office_address
      end

      # For consistency with Australia::Australia and vice-versa...
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

if __FILE__ == $0
  p Parliamentarian::Australia::Victoria.legislative_councillors.first
  p Parliamentarian::Australia::Victoria.legislative_assemblymen.first
  p Parliamentarian::Australia::Victoria.legislative_councillors.count
  p Parliamentarian::Australia::Victoria.legislative_assemblymen.count

  Parliamentarian::Australia::Victoria.legislative_councillors.each do |legislative_councillor|
    puts "Legislative Councillor #{legislative_councillor.first_name} #{legislative_councillor.surname} #{legislative_councillor.email}"
  end

  Parliamentarian::Australia::Victoria.legislative_assemblymen.each do |legislative_assemblyman|
    puts "Legislative Assemblyman #{legislative_assemblyman.first_name} #{legislative_assemblyman.surname} #{legislative_assemblyman.email}"
  end
end
