# String#underscore

# 2010.10.15
# 0.1.0

# Description: The compliment of camelize.  This takes a camel-case word and converts any capitals into lowercase and excepting for a leading capital letter, prepends each with an underscore.  It also converts namespaces to paths, ie. '::' to '/'.  

# History: Almost stolen wholesale from ActiveSupport::Inflector::Inflections#underscore 3.0.0.beta3.  

# Examples: 
# "ActiveRecord".underscore
# => "active_record"
# "ActiveRecord::Errors".underscore
# => active_record/errors

# Changes since 0.0
# 1. Updated with changes from active_support 3.0.0.  
# 2. Will now successfully handle strings with spaces.  
# 3. Removed the dup'ed word since once the transformational methods were chained this became unnecessary.  

class String
  
  def underscore
    gsub(' ', '_').
    gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
  
end
