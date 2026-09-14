# parliamentarian.gemspec

require_relative './lib/Parliamentarian/VERSION'

class Gem::Specification
  def development_dependencies=(gems)
    gems.each{|gem| add_development_dependency(*gem)}
  end
end

Gem::Specification.new do |spec|
  spec.name = 'parliamentarian'
  spec.version = Parliamentarian::VERSION

  spec.summary = "Download and parse details for members of parliament."
  spec.description = "This will download and parse the lastest list of members and their contact details for the alleged parliament of the State of Victoria and the alleged federal parliament for Australia so far."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/parliamentarian'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 2.5'
  spec.require_paths = ['lib']

  spec.files = [
    'parliamentarian.gemspec',
    Dir['lib/**/*.rb'],
    Dir['test/**/*.rb'],
    'CHANGELOG',
    'Gemfile',
    'LICENSE',
    'README.md',
    'Rakefile',
  ].flatten

  spec.development_dependencies = %w{
    minitest
    minitest-spec-context
    webmock
  }
end
