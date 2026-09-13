# Rakefile

require 'rake/testtask'

# The tests carry no _test suffix, so the usual glob finds nothing, and they are
# named directly rather than through test/Parliamentarian.rb: that runner shares
# its name with the library, so requiring it under rake's loader makes
# `require 'Parliamentarian'` from within a test resolve back to the runner which
# is still loading.  Each test puts lib on the load path for itself.
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/Parliamentarian/**/*.rb']
end

task default: :test
