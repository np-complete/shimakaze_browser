require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Comiket < OmniAuth::Strategies::OAuth2
      option :name, 'comiket'
      option :client_options, {
        :site          =>  'https://auth1.circle.ms',
        :authorize_url => '/OAuth2/',
        :token_url     => '/OAuth2/Token'
      }

      uid { raw_info['token'] }

      info do
        {
          :token => raw_info['token'],
          :refresh_token => raw_info['refresh_token']
        }
      end

      extra do
        {
          'raw_info' =>  raw_info
        }
      end

      def raw_info
        @raw_info ||= {
          'token' => access_token.token,
          'refresh_token' => access_token.refresh_token
        }
      end
    end

    class ComiketSandbox < Comiket
      option :name, 'comiket'
      option :client_options, default_options["client_options"].merge(:site => 'https://auth1-sandbox.circle.ms')
    end
  end
end
