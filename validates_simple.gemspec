$:.push File.expand_path("../lib", __FILE__)
require 'validates_simple'

Gem::Specification.new do |s|
  s.name          = 'validates_simple'
  s.version       = Validation::VERSION
  s.date          = '2013-12-15'
  s.summary       = 'makes validation simple'
  s.description   = 'provides a simple way to validate hashes(params, json etc)'
  s.authors       = ['Filip Kostovski']
  s.email         = 'github.sirfilip@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage      = 'https://github.com/sirfilip/validates_simple'
  s.license       = 'MIT'
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
end

