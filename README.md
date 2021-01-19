## Description
Custom omniauth strategy for [Swoop](http://swoopnow.com), a password-free authentication tool.

## Rails Usage
Put `gem 'omniauth-swoop', '0.1.3', github: 'Swoop-Password-Free/omniauth-swoop', branch: 'main'` in your `Gemfile`

In `config/initializers/omniauth.rb` put the following code:
```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :swoop, ENV['SWOOP_ID'], ENV['SWOOP_SECRET']
end
```

`ENV['SWOOP_ID']` should correspond to the `CLIENT_ID` of the `property` you set up via the swoop admin dashboard, and `ENV['SWOOP_SECRET']` should correspond to the property's `SECRET`.

## Testing
If you are contributing to this ruby gem you can test it by:

(1) running `gem build omniauth-swoop.gemspec` from the gem's root directory  
(2) running `bundle update omniauth-swoop` in a test rails app.
