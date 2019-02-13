class ToppagesController < ApplicationController
  def index
    if logged_in?
      @mute = current_user.mutes.build #form_for用
      @mutes = current_user.mutes.order("created_at DESC").page(params[:page])
    end
  end
end
