# Parliamentarian.rb
# Parliamentarian

# 20191020
# 0.6.0

# Changes since 0.5:
# 1. + Parliamentarian::Australia::Victoria#extract_postcode_from_electorate_office_address
# 2. + Parliamentarian::Australia::Federal#postcode, so that it marries up with Parliamentarian::Australia::Victoria#postcode.
# 3. + Parliamentarian::Australia::Federal#first_name, so that it marries up with Parliamentarian::Australia::Victoria#firstname.
# 4. + Parliamentarian::Australia::Federal#surname, so that it marries up with Parliamentarian::Australia::Victoria#lastname.
# 5. + Parliamentarian::Australia::Victoria#firstname, so that it marries up with Parliamentarian::Australia::Federal#first_name.
# 6. + Parliamentarian::Australia::Victoria#lastname, so that it marries up with Parliamentarian::Australia::Federal#surname.
# 7. ~ Parliamentarian::Australia::Federal#synthesize_email_address, so that it is consistent with what is in the PDF listing.

require_relative 'Parliamentarian/Australia'
