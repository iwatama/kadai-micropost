class OkiniirisController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.nice(micropost)
    flash[:success] = 'niceしました。'
    #redirect_to user
    redirect_back(fallback_location: root_path)
  end


  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unnice(micropost)
    flash[:success] = 'niceを解除しました。'
    #redirect_to user
    redirect_back(fallback_location: root_path)
  end

end
