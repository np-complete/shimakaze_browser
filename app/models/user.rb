class User < ActiveRecord::Base
  devise :omniauthable
  attr_accessor :token

  def self.from_token(token)
    user = User.new
    user.token = token
    user
  end
end
