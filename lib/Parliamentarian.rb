# Parliamentarian.rb
# Parliamentarian

# 20210408
# 0.8.5

# Changes since 0.7:
# 0: Paramterised the location of the CSV files so that it can be a local file or the original URL by default with a view to making use of those files as fixtures for tests.
# 1. ~ Australia::Federal.fetch, .senators, .members, so that one is able to supply a csv file location.
# 2. ~ Australia::Victoria.fetch, .legislative_councillors, .legislative_assemblymen, so that one is able to supply a csv file location.
# 3. Removed the self-run sections from Australia::Federal and Australia::Victoria with proper tests in their stead.
# 4. + ./test
# 0/1
# 5. /require 'SimpleCSV.rbd'/SimpleCSV/require 'SimpleCSV'/
# 1/2
# 6. Swapped Victorian councillors and assemblymen URLs as they were the reverse of what they should be.
# 7. /legislative_assemblymen/legislative_assemblymembers/, so as to be consistent with the CSV filename being downloaded.
# 2/3
# 8. Underscored all the dynamically created methods for each of the column names in the CSV files.
# 3/4
# 9. Missed some aliases when underscoring in the previous version.
# 4/5
# 10. + VERSION file
# 11. + parliamentarian.gemspec
# 12. ~ Gemfile to include webmock.
# 13. + required lib files (to be broken out later.)

lib_dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require_relative 'Parliamentarian/Australia'
