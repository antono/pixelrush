class PixelsController < ApplicationController
  before_action :enforce_current_user

  def create_bulk
    red = params[:color][0]
    green = params[:color][1]
    blue = params[:color][2]

    params[:range].each do |x,y|
      Pixel.create(
        user_id: current_user.id,
        red: red,
        green: green,
        blue: blue,
        x: x,
        y: y,
      )
    end
  end

  private

  def enforce_current_user
    if current_user.blank?
      redirect_to new_session_path
    end
  end
end
