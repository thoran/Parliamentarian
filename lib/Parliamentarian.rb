# Parliamentarian.rb
# Parliamentarian

# 20200525
# 0.8.0

# Changes since 0.7:
# 0: Paramterised the location of the CSV files so that it can be a local file or the original URL by default with a view to making use of those files as fixtures for tests.
# 1. ~ Australia::Federal.fetch, .senators, .members, so that one is able to supply a csv file location.
# 2. ~ Australia::Victoria.fetch, .legislative_councillors, .legislative_assemblymen, so that one is able to supply a csv file location.
# 3. Removed the self-run sections from Australia::Federal and Australia::Victoria with proper tests in their stead.
# 4. + ./test

require_relative 'Parliamentarian/Australia'
