class TopController < ApplicationController
  def index
    render 'about' unless user_signed_in?
  end

  def about
    render 'about'
  end
end
