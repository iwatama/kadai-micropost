class OkiniirisController < ApplicationController
  before_action :require_user_logged_in

  def create
    user = Micropost.find(params[:micropost_id])
    current_user.nice(user)
    flash[:success] = 'niceしました。'
    ##redirect_to user
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = Micropost.find(params[:micropost_id])
    current_user.unnice(user)
    flash[:success] = 'niceを解除しました。'
    redirect_back(fallback_location: root_path)
  end

end
