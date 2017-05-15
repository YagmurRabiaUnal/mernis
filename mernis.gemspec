# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mernis/version'

Gem::Specification.new do |s|
  s.name        = 'mernis'
  s.version     = '1.0.2'
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'SOAP client for KPS [MERNIS] services.'
  s.description = 'SOAP client for MERNIS services provided by Ministry of the Interior, Turkey'
  s.author      = 'Mustafa Serhat Dündar'
  s.email       = 'msdundars@gmail.com'
  s.files       = ['lib/mernis.rb', 'lib/mernis/request.rb']
  s.homepage    = 'https://github.com/msdundar/mernis'
  s.licenses    = ['MIT']

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency "savon", '~> 2.11'
  s.required_ruby_version = '>= 2.2.0'
end
