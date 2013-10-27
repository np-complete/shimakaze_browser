require 'oauth2/access_token'

class User < ActiveRecord::Base
  devise :omniauthable

  def self.serialize_from_session(key, salt)
    super(key, salt).with_refresh
  end

  def self.from_token(token)
    c = token.credentials
    attrs = {
      access_token: c.token,
      refresh_token: c.refresh_token,
      expires_at: c.expires_at,
      provider: token.provider
    }
    create(attrs)
  end

  def refresh_token!
    oauth_config = Devise.omniauth_configs[:comiket].strategy
    client = OAuth2::Client.new(oauth_config.client_id, oauth_config.client_secret, oauth_config.client_options.symbolize_keys)
    token = build_token(client).refresh!
    update_attributes(access_token: token.token, refresh_token: token.refresh_token, expires_at: token.expires_at)
    self
  end

  def with_refresh
    refresh_token! if expired?
    self
  end

  protected

  def expired?
    expires_at < Time.now.to_i if expires_at
  end

  def build_token(client)
    token_hash = {
      access_token: access_token,
      refresh_token: refresh_token,
      expires_at: expires_at
    }
    OAuth2::AccessToken.from_hash(client, token_hash)
  end
end
