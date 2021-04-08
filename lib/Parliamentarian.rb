# Parliamentarian.rb
# Parliamentarian

# 20200525
# 0.7.0

# Changes since 0.6:
# 0: Removed the code to parse .xls files after an apparent cock-up whereby the Australian Federal Members file was in .xls format even if a .csv extension was supplied, and if the .csv extension were supplied it would fail, but now when supplying the extension .xls it supplies a file in CSV format. Of course!
# 1. - require 'roo-xls'
# 2. - Australia::Federal.fetch_xls
# 3. /open/URI.open/, in line with deprecation warnings.
# 4. + last_name() and reformatted them as if they were alias_methods since they wouldn't work because the aliased methods are created dynamically.
# 5. ~ self-run section in Australia::Federal: /electoratestate/electorate_state/, because the column headers now include spaces between the words.

require_relative 'Parliamentarian/Australia'
