# test/Parliamentarian/Australia/Federal.rb

require 'minitest/autorun'
require 'minitest-spec-context'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

lib_dir = File.expand_path(File.join('..', '..', '..', '..', 'lib'), __FILE__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'Parliamentarian'

describe Parliamentarian::Australia::Federal do
  let(:senators_csv_filename) do
    File.expand_path(File.join('..', '..', '..', 'fixtures', 'Australia', 'Federal', 'allsenel.csv'), __FILE__)
  end
  let(:senators_csv_file) do
    File.read(senators_csv_filename)
  end
  let(:members_csv_filename) do
    File.expand_path(File.join('..', '..', '..', 'fixtures', 'Australia', 'Federal', 'SurnameRepsCSV.csv'), __FILE__)
  end
  let(:members_csv_file) do
    File.read(members_csv_filename)
  end

  context "HTTP request" do
    before do
      stub_request(:get, "https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/Senators/allsenel.csv?la=en").
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: senators_csv_file, headers: {})
      stub_request(:get, "https://www.aph.gov.au/~/media/03%20Senators%20and%20Members/Address%20Labels%20and%20CSV%20files/SurnameRepsCSV.csv?la=en").
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: members_csv_file, headers: {})
    end

    describe ".all" do
      it "retrieves 227 rows" do
        expect(Parliamentarian::Australia::Federal.all.count).must_equal 227
      end
    end

    describe ".senators" do
      it "retrieves 77 rows" do
        expect(Parliamentarian::Australia::Federal.senators.count).must_equal 77
      end

      it "contains elements of class Parliamentarian::Australia::Federal" do
        expect(Parliamentarian::Australia::Federal.senators.first.class).must_equal Parliamentarian::Australia::Federal
      end
    end

    describe ".members" do
      it "retrieves 150 rows" do
        expect(Parliamentarian::Australia::Federal.members.count).must_equal 150
      end

      it "contains elements of class Parliamentarian::Australia::Federal" do
        expect(Parliamentarian::Australia::Federal.members.first.class).must_equal Parliamentarian::Australia::Federal
      end
    end
  end

  context "local file" do
    describe ".all" do
      it "retrieves 227 rows" do
        expect(Parliamentarian::Australia::Federal.all(senators_csv_filename, members_csv_filename).count).must_equal 227
      end
    end

    describe ".senators" do
      it "retrieves 77 rows" do
        expect(Parliamentarian::Australia::Federal.senators(senators_csv_filename).count).must_equal 77
      end

      it "contains elements of class Parliamentarian::Australia::Federal" do
        expect(Parliamentarian::Australia::Federal.senators(senators_csv_filename).first.class).must_equal Parliamentarian::Australia::Federal
      end
    end

    describe ".members" do
      it "retrieves 150 rows" do
        expect(Parliamentarian::Australia::Federal.members(members_csv_filename).count).must_equal 150
      end

      it "contains elements of class Parliamentarian::Australia::Federal" do
        expect(Parliamentarian::Australia::Federal.members(members_csv_filename).first.class).must_equal Parliamentarian::Australia::Federal
      end
    end
  end
end
