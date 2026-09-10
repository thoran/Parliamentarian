# test/Parliamentarian/VERSION.rb

require 'minitest/autorun'
require 'minitest-spec-context'

lib_dir = File.expand_path(File.join('..', '..', '..', 'lib'), __FILE__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'Parliamentarian'

describe Parliamentarian do
  describe "VERSION" do
    it "is a string" do
      _(Parliamentarian::VERSION).must_be_instance_of String
    end

    it "is three numbers separated by dots" do
      _(Parliamentarian::VERSION).must_match(/\A\d+\.\d+\.\d+\z/)
    end
  end
end
