# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Stefan Wienert"]
  gem.email         = ["stefan.wienert@pludoni.de"]
  gem.description   = %q{Generates has-and-belongs-to-many migrations. Use rails generate habtm model1 model2}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/zealot128/ruby-habtm-generator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "habtm_generator"
  gem.require_paths = ["lib"]
  gem.version       = "0.1"
  gem.add_dependency "activerecord", ">3.1"
end
