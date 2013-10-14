class TopController < ApplicationController
  def index
    render 'about' unless user_signed_in?
  end

  def about
    render 'about'
  end

  def logout
    sign_out :user
    redirect_to :root
  end
end
