# MERNİS (KPS)

SOAP client for KPS (The Identity Information Sharing System) services provided by Ministry of the Interior, Turkey

[![Gem Version](https://badge.fury.io/rb/mernis.svg)](http://badge.fury.io/rb/mernis)
[![Code Climate](https://codeclimate.com/github/msdundar/mernis/badges/gpa.svg)](https://codeclimate.com/github/msdundar/mernis)

## Setup

```
$ gem install 'mernis'
```

## Usage Examples

```ruby
require 'mernis'

# Most basic usage:
mernis = Mernis.sorgula("11223344556", "john", "doe", "1990")

# With parameter names (required only):
mernis = Mernis.sorgula(id_number="11223344556", first_name="john", last_name="doe", birth_year="1990")

# With parameter names (required + extras):
mernis = Mernis.sorgula(id_number="11223344556", first_name="john", last_name="doe", birth_year="1990", version = 2, log = false)

# With all parameters:
mernis = Mernis.sorgula(id_number="11223344556", first_name="john", last_name="doe", birth_year="1990", version = 2, open_timeout = 60, read_timeout = 60, log = false, wsdl = "https://somecustomwsdl.com" )

```

## Parameters

```ruby
mernis = Mernis.sorgula(
      id_number = "12345", # identity number
      first_name = "john", # first name
      last_name = "doe",   # last name
      birth_year = "1990", # year of birth
      version = 2,         # soap version. should be 1 or 2.
      open_timeout = 60,   # timeout duration until SOAP server opens the connection. in seconds.
      read_timeout = 60,   # timeout duration until SOAP server returns response. in seconds.
      log = false,         # logging
      wsdl = "https://somecustomwsdl.com" # wsdl uri
    )
```

## Response

Returns true if the identity number can be validated and false if not. Both returning values are string!

## Contributing

1. `fork` the repo ( https://github.com/msdundar/mernis/fork )
2. Create a branch (git checkout -b cool-feature)
3. Commit the changes (git commit -am 'My cool features')
4. Push the branch (git push origin cool-feature)
5. Make a pull request

# Build

```ruby
gem build mernis.gemspec
gem install ./mernis-1.0.2.gem
gem push mernis-1.0.2.gem
git tag -a v1.0.2 -m "Major updates"
git push --tags
```

## Questions

```
msdundars@gmail.com
```
