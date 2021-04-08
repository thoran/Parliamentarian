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

        def fetch(url)
          raw_csv = URI.open(url)
          SimpleCSV.read(raw_csv, headers: true)
        end

        def all
          @all ||= senators + members
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

if __FILE__ == $0
  p Parliamentarian::Australia::Federal.senators.first
  p Parliamentarian::Australia::Federal.members.first
  p Parliamentarian::Australia::Federal.senators.count
  p Parliamentarian::Australia::Federal.members.count

  Parliamentarian::Australia::Federal.senators.select do |senator|
    senator.electorate_state =~ /VIC/i
  end.each do |senator|
    puts "Senator #{senator.first_name} #{senator.surname} #{senator.email}"
  end

  Parliamentarian::Australia::Federal.members.select do |member|
    member.electorate_state =~ /VIC/i
  end.each do |member|
    puts "Member #{member.first_name} #{member.surname} #{member.email}"
  end
end
