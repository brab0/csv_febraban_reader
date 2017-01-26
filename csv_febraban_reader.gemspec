# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_febraban_reader/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_febraban_reader"
  spec.version       = CsvFebrabanReader::VERSION
  spec.authors       = ["Rodrigo Brabo"]
  spec.email         = ["brabo.rodrigo@gmail.com"]

  spec.summary       = %q{Gem pra interpretar fatura febraban.}
  spec.description   = %q{Gem pra interpretar fatura febraban do tipo csv.}
  spec.homepage      = "https://github.com/brab0/csv_febraban_reader"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = 'MIT'
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
