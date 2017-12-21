# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bragi/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bragi'
  s.version     = Bragi::VERSION
  s.authors     = ['William Johnston']
  s.email       = ['wjohnston@mpr.org']
  s.homepage    = 'https://github.com/APMG/bragi-api'
  s.summary     = 'API Backend for user audio queue/playlist'
  # s.description = "TODO: Description of Bragi."
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'active_model_serializers', '~> 0.10.0'
  s.add_dependency 'kaminari-activerecord', '~> 1.0'
  s.add_dependency 'rails', '~> 5.0.2'
  s.add_dependency 'wisper', '~> 2.0'

  s.add_development_dependency 'mysql2'
end
