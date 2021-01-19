# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'omniauth-swoop'
  s.version     = '0.1.4'
  s.date        = '2021-01-19'
  s.homepage    = "https://github.com/swoop-password-free/omniauth-swoop"
  s.description = %q{OmniAuth strategy for Swoop passwordless authentication}
  s.summary     = s.description
  s.authors     = ["Brandon Trebitowski", "Charlie Wisoff"]
  s.email       = 'brandon@swoopnow.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new('>= 1.9.3')
  s.add_dependency 'omniauth-oauth2', '~> 1.7.1'
  s.add_development_dependency 'bundler', '~> 1.0'
end
