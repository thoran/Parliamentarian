# test/Parliamentarian/Australia/Victoria.rb

require 'minitest/autorun'
require 'minitest-spec-context'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

lib_dir = File.expand_path(File.join('..', '..', '..', '..', 'lib'), __FILE__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'Parliamentarian'

describe Parliamentarian::Australia::Victoria do
  let(:legislative_councillors_csv_filename) do
    File.expand_path(File.join('..', '..', '..', 'fixtures', 'Australia', 'Victoria', 'councilmembers.csv'), __FILE__)
  end
  let(:legislative_councillors_csv_file) do
    File.read(legislative_councillors_csv_filename)
  end
  let(:legislative_assemblymen_csv_filename) do
    File.expand_path(File.join('..', '..', '..', 'fixtures', 'Australia', 'Victoria', 'assemblymembers.csv'), __FILE__)
  end
  let(:legislative_assemblymen_csv_file) do
    File.read(legislative_assemblymen_csv_filename)
  end

  context "HTTP request" do
    before do
      stub_request(:get, "https://www.parliament.vic.gov.au/images/members/assemblymembers.csv").
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: legislative_councillors_csv_file, headers: {})
      stub_request(:get, "https://www.parliament.vic.gov.au/images/members/councilmembers.csv").
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: legislative_assemblymen_csv_file, headers: {})
    end

    describe ".all" do
      it "retrieves 128 rows" do
        expect(Parliamentarian::Australia::Victoria.all.count).must_equal 128
      end
    end

    describe ".legislative_councillors" do
      it "retrieves 40 rows" do
        expect(Parliamentarian::Australia::Victoria.legislative_councillors.count).must_equal 40
      end

      it "contains elements of class Parliamentarian::Australia::Victoria" do
        expect(Parliamentarian::Australia::Victoria.legislative_councillors.first.class).must_equal Parliamentarian::Australia::Victoria
      end
    end

    describe ".legislative_assemblymen" do
      it "retrieves 88 rows" do
        expect(Parliamentarian::Australia::Victoria.legislative_assemblymen.count).must_equal 88
      end

      it "contains elements of class Parliamentarian::Australia::Victoria" do
        expect(Parliamentarian::Australia::Victoria.legislative_assemblymen.first.class).must_equal Parliamentarian::Australia::Victoria
      end
    end
  end

  context "local file" do
    describe ".all" do
      it "retrieves 128 rows" do
        expect(Parliamentarian::Australia::Victoria.all(legislative_councillors_csv_filename, legislative_assemblymen_csv_filename).count).must_equal 128
      end
    end

    describe ".legislative_councillors" do
      it "retrieves 40 rows" do
        expect(Parliamentarian::Australia::Victoria.legislative_councillors(legislative_councillors_csv_filename).count).must_equal 40
      end

      it "contains elements of class Parliamentarian::Australia::Victoria" do
        expect(Parliamentarian::Australia::Victoria.legislative_councillors(legislative_councillors_csv_filename).first.class).must_equal Parliamentarian::Australia::Victoria
      end
    end

    describe ".legislative_assemblymen" do
      it "retrieves 88 rows" do
        expect(Parliamentarian::Australia::Victoria.legislative_assemblymen(legislative_assemblymen_csv_filename).count).must_equal 88
      end

      it "contains elements of class Parliamentarian::Australia::Victoria" do
        expect(Parliamentarian::Australia::Victoria.legislative_assemblymen(legislative_assemblymen_csv_filename).first.class).must_equal Parliamentarian::Australia::Victoria
      end
    end
  end
end
