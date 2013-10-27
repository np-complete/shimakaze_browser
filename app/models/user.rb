require 'oauth2/access_token'

class User < ActiveRecord::Base
  devise :omniauthable
  attr_accessor :token

  def self.serialize_into_session(record)
    [record.token, nil]
  end

  def self.serialize_from_session(key, salt)
    user = User.new
    user.token = key
    user
  end

  def self.from_token(token)
    user = User.new
    user.token = token
    user
  end

  def access_token
    OAuth2::AccessToken.from_hash(Comiket.client, token.credentials)
  end
end
