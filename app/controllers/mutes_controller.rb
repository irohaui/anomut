class MutesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def create
    @mute = current_user.mutes.build(mute_params)
    if @mute.save
      flash[:success] = "メッセージを投稿しました"
      redirect_to root_url
    else
      @mutes = current_user.mutes.order("created DESC").page(params[:page])
      flash.now[:danger] = "メッセージの投稿に失敗しました"
      render "toppages/index"
    end
  end

  def destroy
    @mute.destroy
    flash[:success] = "メッセージを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def mute_params
    params.require(:mute).permit(:content)
  end

  def correct_user
    @mute = current_user.mutes.find_by(id: params[:id])
    unless @mute
      redirect_to root_url
    end
  end

end
