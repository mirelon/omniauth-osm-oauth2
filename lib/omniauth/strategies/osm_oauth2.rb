# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class OsmOauth2 < OmniAuth::Strategies::OAuth2
      option :name, "osm_oauth2"

      option :client_options, {:site => "https://api.somesite.com"}

      option :pkce, true

      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end