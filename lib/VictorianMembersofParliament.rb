# VictorianMembersofParliament.rb
# VictorianMembersofParliament

# 20171115
# 0.0.0

require 'open-uri'
require 'SimpleCSV.rbd/SimpleCSV'

class VictorianMembersofParliament

  URL = 'https://www.parliament.vic.gov.au/component/fabrik/list/27?format=csv&resetfilters=1&incraw=0'

  class << self

    def fetch
      raw_csv = open(URL)
      SimpleCSV.read(raw_csv, headers: true)
    end

    def all
      @all ||= fetch.each{|row| self.new(row)}
    end

  end # class << self

  def initialize(row)
    # dynamic attr setting necessary
  end

end
