# Parliamentarian.rb
# Parliamentarian

# 20191020
# 0.5.0

# Changes since 0.4:
# 1. ~ Parliamentarian::Australia::Federal::SENATE_URL, just because and for no apparent good reason it seems to me!
# 2. + require 'roo-xls', because...
# 3. ~ Parliamentarian::Australia::Federal::HOUSE_OF_REPRESENTATIVES_URL (though the same as before except it) now has an .xls extension and points to a .xls file even though it purports to be a .csv file!
# 4. + Gemfile
# 5. ~ Parliamentarian::Australia::Federal#synthesize_email_address, so that it produces a different email address for senators than for members and so that the order of first name and last name for members is reversed and correct.
# 6. + Parliamentarian::Australia::Federal#senator?
# 7. + Parliamentarian::Australia::Federal#member?
# 8. + require_relative 'Parliamentarian/Australia'
# 9. - require_relative 'Parliamentarian/Australia/Federal'
# 10. - require_relative 'Parliamentarian/Australia/Victoria'

require_relative 'Parliamentarian/Australia'
