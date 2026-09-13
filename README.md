# Parliamentarian

## Description

Download and parse the current list of members of parliament, and their contact
details, from the parliaments which publish one as a CSV.

Two are covered so far: the federal parliament of Australia, and the parliament of
the State of Victoria. Each chamber is a method, and each row comes back as an
object whose attributes are the column headings underscored, so a CSV which gains
a column gains an attribute without anything here being changed.

## Installation

### 0. Have a recent version of Ruby installed

### 1. Via RubyGems

```shell
$ gem install parliamentarian
```

Or in a Gemfile:

```ruby
gem 'parliamentarian'
```

## Usage

### Australia, federally

```ruby
require 'parliamentarian'

Parliamentarian::Australia::Federal.senators
# => [#<Parliamentarian::Australia::Federal>, ...], the Senate

Parliamentarian::Australia::Federal.members
# => [#<Parliamentarian::Australia::Federal>, ...], the House of Representatives

Parliamentarian::Australia::Federal.all
# => both chambers together
```

### Victoria

```ruby
Parliamentarian::Australia::Victoria.legislative_councillors
# => [#<Parliamentarian::Australia::Victoria>, ...], the upper house

Parliamentarian::Australia::Victoria.legislative_assemblymembers
# => [#<Parliamentarian::Australia::Victoria>, ...], the lower house

Parliamentarian::Australia::Victoria.all
# => both houses together
```

### A member

The attributes are the CSV's own column headings, underscored:

```ruby
member = Parliamentarian::Australia::Victoria.legislative_councillors.first

member.last_name        # => "Smith"
member.preferred_name   # => "Jane"
member.electorate       # => "Southern Metropolitan"
member.party            # => "Australian Labor Party"
member.eo_postcode      # => "3000", taken from the electorate office address
```

`first_name`, `firstname`, `lastname` and `surname` are aliases, the two
parliaments not agreeing on which of them to publish.

### Reading from a file rather than the web

Each method takes a path, which is what the tests use and what a cached copy
wants:

```ruby
Parliamentarian::Australia::Victoria.legislative_councillors('councilmembers.csv')
Parliamentarian::Australia::Victoria.all('councilmembers.csv', 'assemblymembers.csv')
```

A path is read from disk and anything with an `http` or `https` scheme is
fetched, so the same method serves both.

## Contributing

1. Fork it: `https://github.com/thoran/Parliamentarian/fork`
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create a new pull request

## License

MIT
