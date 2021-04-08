# VictorianMemberofParliament.rb
# VictorianMemberofParliament

# 20171119
# 0.2.0

require 'open-uri'
require 'SimpleCSV.rbd/SimpleCSV'

class VictorianMemberofParliament

  URL = 'https://www.parliament.vic.gov.au/component/fabrik/list/27?format=csv&resetfilters=1&incraw=0'

  class << self

    def fetch
      raw_csv = open(URL)
      SimpleCSV.read(raw_csv, headers: true)
    end

    def all
      @all ||= fetch.collect{|row| self.new(row)}
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

if __FILE__ == $0
  require 'fileutils'
  FileUtils.touch('victorian_members_of_parliament.csv')
  csv_file = SimpleCSV.new('victorian_members_of_parliament.csv', mode: 'r+', headers: true)
  csv_file.rows = VictorianMemberofParliament.fetch
  csv_file.write
end
