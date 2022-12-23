# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  skip_before_action :verify_authenticity_token

  private

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    @current_user ||=
      if session[:user_id]
        User.find_by(id: session[:user_id])
      end
  end
end
