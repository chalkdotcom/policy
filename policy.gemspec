require File.expand_path('../lib/policy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec'
  gem.add_runtime_dependency 'activesupport'

  gem.authors = ['Ryan McKay-Fleming']
  gem.description = %q{Policy objects for Rails}
  gem.email = ['ryan@chalk.com']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/chalkdotcom/policy'
  gem.name = 'policy'
  gem.require_paths = ['lib']
  gem.summary = %q{Policy objects for Rails}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = Policy::VERSION.dup
end