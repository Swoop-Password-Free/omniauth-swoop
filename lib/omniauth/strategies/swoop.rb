require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Swoop < OmniAuth::Strategies::OAuth2

      include OmniAuth::Strategy

      option :name, "swoop"

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

      option :redirect_url

      uid do
        fetch_user_info(user_paths[:id_path]).to_s
      end

      info do
        user_paths[:attributes].inject({}) do |user_hash, (field, path)|
          value = fetch_user_info(path)
          user_hash[field] = value if value
          user_hash
        end
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get(options.client_options[:user_info_url]).parsed
        @raw_info["id_token"] = access_token.params["id_token"]
      end

      def authorize_params
        params = super
        Hash[params.map { |k, v| [k, v.respond_to?(:call) ? v.call(request) : v] }]
      end

      private

      def user_paths
        options.user_response_structure
      end

      def fetch_user_info(path)
        return nil unless path
        full_path = path.is_a?(Array) ? path : Array(user_paths[:root_path]) + [path]
        full_path.inject(raw_info) { |info, key| info[key] rescue nil }
      end

      def callback_url
        options.redirect_url || (full_host + script_name + callback_path)
      end

    end
  end
end
