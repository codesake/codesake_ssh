# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codesake/ssh/version'

Gem::Specification.new do |gem|
  gem.name          = "codesake_ssh"
  gem.version       = Codesake::SSH::VERSION
  gem.authors       = ["Paolo Perego"]
  gem.email         = ["paolo@armoredcode.com"]
  gem.description   = %q{Codesake::SSH includes all security checks we apply to ssh service for codesake application security portal}
  gem.summary       = %q{Codesake::SSH includes all security checks we apply to ssh service for codesake application security portal}
  gem.homepage      = "http://codesake.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
