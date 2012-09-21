# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion-resource/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daniel Wanja"]
  gem.email         = ["d@n-so.com"]
  gem.description   = "MotionResource a library to consume Ruby on Rails resources. Supports CRUD, nested resources and nested attributes."
  gem.summary       = "MotionResource a library to consume Ruby on Rails resources. Supports CRUD, nested resources and nested attributes."
  gem.homepage      = "http://n-so.com/opensource/motion_resource"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|lib_spec|features)/})
  gem.name          = "motion-resource"
  gem.require_paths = ["lib"]
  gem.version       = MotionResource::VERSION

  gem.extra_rdoc_files = gem.files.grep(%r{motion})

  gem.add_dependency 'bubble-wrap'

  gem.add_development_dependency 'mocha', '0.11.4'
  gem.add_development_dependency 'mocha-on-bacon'
  gem.add_development_dependency 'bacon'
  gem.add_development_dependency 'rake'
end