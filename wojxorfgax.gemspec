# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'wojxorfgax/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'wojxorfgax'
  s.version     = Wojxorfgax::VERSION
  s.authors     = ['William Johnston']
  s.email       = ['wjohnston@mpr.org']
  s.homepage    = 'https://gitlab.mpr.org/ruby-libraries/wojxorfgax'
  s.summary     = 'API Backend for user audio queue/playlist'
  # s.description = "TODO: Description of Wojxorfgax."
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.2'
  s.add_dependency 'active_model_serializers', '~> 0.10.0'

  s.add_development_dependency 'mysql2'
end
