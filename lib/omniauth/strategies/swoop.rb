require 'omniauth-oauth2'
require 'jwt'

module OmniAuth
  module Strategies
    class Swoop < OmniAuth::Strategies::OAuth2
      option :name, "swoop"

      option :client_options, {
        site: 'https://auth.swoop.email',
        token_url: '/oauth2/token',
        user_info_url: '/oauth2/profile'
      }

      option :pkce, true

      option :authorize_params, {
          scope: 'email'
      }

      option :redirect_url

      uid do
        info["uid"]
      end

      info do
      {
        :uid => raw_info['sub'],
        :email => raw_info['email'],
        :user_meta => raw_info['user_meta']
      }

      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get(options.client_options[:user_info_url]).parsed
        id_token = access_token.params["id_token"]

        decoded_token = JWT.decode id_token, options.client_secret, true, { algorithm: 'HS256' }

        if(decoded_token[0].key?("user_meta"))
          @raw_info["user_meta"] = decoded_token[0]["user_meta"]
        end

        @raw_info["id_token"] = id_token
        @raw_info
      end

      def authorize_params
        params = super
        p = Hash[params.map { |k, v| [k, v.respond_to?(:call) ? v.call(request) : v] }]

        request_params = request.params
        property_meta = {}
        if request_params.key?("property_method")
          property_meta["method"] = request_params["property_method"]
          request_params.delete("property_method")
        end
        if request_params.key?("property_name")
          property_meta["name"] = request_params["property_name"]
          request_params.delete("property_name")
        end
        if request_params.key?("property_logo_url")
          property_meta["logo_url"] = request_params["property_logo_url"]
          request_params.delete("property_logo_url")
        end
        if request_params.key?("property_primary_color")
          property_meta["primary_color"] = request_params["property_primary_color"]
          request_params.delete("property_primary_color")
        end

        if property_meta.length > 0
          property_meta = JWT.encode property_meta, options.client_secret, 'HS256'
          p["property_meta"] = property_meta
        end

        p = p.merge(request_params)
        p
      end

      private

      def callback_url
        options.redirect_url || (full_host + script_name + callback_path)
      end

    end
  end
end
