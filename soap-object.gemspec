# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soap-object/version'

Gem::Specification.new do |gem|
  gem.name          = "soap-object"
  gem.version       = Soap::Object::VERSION
  gem.authors       = ["Jeffrey S. Morgan", "Doug Morgan"]
  gem.email         = ["jeff.morgan@leandog.com", "douglas.morgan3405@gmail.com"]
  gem.description   = %q{Wrapper around SOAP service calls to make it easy to test}
  gem.summary       = %q{Wrapper around SOAP service calls to make it easy to test}
  gem.homepage      = "http://github.com/cheezy/soap-object"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'savon', '>= 2.2.0'

  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'cucumber', '>= 1.2.0'
end
