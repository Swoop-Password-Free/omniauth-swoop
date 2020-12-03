require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Swoop < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://auth.swoop.email', 
        token_url: '/oauth2/token',
        user_info_url: '/oauth2/profile'
      }

      option :user_response_structure, {
        attributes: {
          email: 'email',
          uid: 'sub'
        }
      }

      option :authorize_params, {
          scope: 'email'
      }

      option :name, "swoop"
    end
  end
end