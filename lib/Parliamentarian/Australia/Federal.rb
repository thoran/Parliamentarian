# Parliamentarian/Australia/Federal.rb
# Parliamentarian::Australia::Federal

require 'open-uri'
require 'SimpleCSV.rbd/SimpleCSV'

module Parliamentarian
  module Australia
    class Federal

      SENATE_URL = 'https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/Senators/allsenel.csv?la=en'
      HOUSE_OF_REPRESENTATIVES_URL = 'https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/SurnameRepsCSV.csv?la=en'

      class << self

        def fetch(csv_file_location)
          raw_csv = if ['http', 'https'].include?(URI.parse(csv_file_location).scheme)
            URI.open(csv_file_location)
          else
            File.read(csv_file_location)
          end
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all(senators_csv_file_location = nil, members_csv_file_location = nil)
          @all ||= (senators(senators_csv_file_location) + house_of_representatives(members_csv_file_location)).flatten
        end

        def senators(csv_file_location = nil)
          @senators ||= (
            csv_file_location = csv_file_location || SENATE_URL
            fetch(csv_file_location).collect{|row| self.new(row)}
          )
        end
        alias_method :senate, :senators

        def members(csv_file_location = nil)
          @members ||= (
            csv_file_location = csv_file_location || HOUSE_OF_REPRESENTATIVES_URL
            fetch(csv_file_location).collect{|row| self.new(row)}
          )
        end
        alias_method :house_of_representatives, :members

      end # class << self

      def initialize(row)
        row.keys.each do |header|
          attr_name = self.attr_name(header)
          self.class.send(:attr_accessor, attr_name)
          self.send("#{attr_name}=", row[header])
        end
        synthesize_email_address
      end

      # For consistency with Australia::Victoria and vice-versa...
      def firstname; first_name; end
      def lastname; surname; end
      def last_name; surname; end

      def postcode
        @electorate_postcode
      end

      # predicate methods

      def senator?
        salutation == 'Senator'
      end

      def member?
        !senator?
      end

      private

      def attr_name(header)
        if header =~ / /
          header.split.collect{|word| word.downcase}.join('_')
        else
          header.downcase
        end
      end

      def synthesize_email_address
        self.class.send(:attr_accessor, 'email')
        self.email = (
          if senator?
            "senator.#{surname.downcase}@aph.gov.au"
          else
            "#{first_name}.#{surname}.MP@aph.gov.au"
          end
        )
      end

    end
  end
end
