class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def comiket
    sign_in User.from_token(request.env['omniauth.auth'])
    redirect_to :root
  end
end
