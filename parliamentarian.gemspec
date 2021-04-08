require_relative './lib/Parliamentarian/VERSION'

Gem::Specification.new do |spec|
  spec.name = 'parliamentarian'

  spec.version = Parliamentarian::VERSION
  spec.date = '2021-04-08'

  spec.summary = "Download and parse details for members of parliament."
  spec.description = "This will download and parse the lastest list of members and their contact details for the alleged parliament of the State of Victoria and the alleged federal parliament for Australia so far."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/Parliamentarian'
  spec.license = 'Ruby'

  spec.files = Dir['lib/**/*.rb']
  spec.required_ruby_version = '>= 2.5'

  spec.add_development_dependency('minitest')
  spec.add_development_dependency('minitest-spec-context')
  spec.add_development_dependency('webmock')
end
