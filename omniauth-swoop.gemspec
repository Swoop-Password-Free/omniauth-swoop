Gem::Specification.new do |s|
  s.name        = 'omniauth-swoop'
  s.version     = '0.1.2'
  s.date        = '2020-12-04'
  s.summary     = "Custom omniauth strategy for swoopnow.com passwordless authentication"
  s.authors     = ["Charlie Wisoff"]
  s.email       = 'charlie@swoopnow.com'
  s.files       = ["lib/omniauth-swoop.rb"]
  s.add_runtime_dependency 'omniauth-oauth2'
end