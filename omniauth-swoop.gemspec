Gem::Specification.new do |s|
  s.name        = 'omniauth-swoop'
  s.version     = '0.1.3'
  s.date        = '2021-01-19'
  s.summary     = "Custom omniauth strategy for swoopnow.com passwordless authentication"
  s.authors     = ["Brandon Trebitowski", "Charlie Wisoff"]
  s.email       = 'brandon@swoopnow.com'
  s.files       = ["lib/omniauth-swoop.rb"]
  s.add_runtime_dependency 'omniauth-oauth2'
end
