class FavaritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    micropost = Micropost.find(params[:post_id])
    current_user.good(micropost)
    flash[:success] = 'ユーザをフォローしました。'
    redirect_to user
  end

  def destroy
    micropost = Micropost.find(params[:post_id])
    current_user.ungood(micropost)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_to user
  end
end