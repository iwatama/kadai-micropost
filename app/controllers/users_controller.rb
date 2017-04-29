class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :niceings]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def niceings
    @user = User.find(params[:id])
    @niceings = @user.niceings.page(params[:page])
    ## @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def nice(other_user)
    unless self == other_user
      self.okiniiris.find_or_create_by(user_id: other_user.id)
    end
  end

  def unnice(other_user)
    okiniiri = self.okiniiris.find_by(user_id: other_user.id)
    okiniiris.destroy if okiniiri
  end

  def nice?(other_user)
    self.niceings.include?(other_user)
  end
  


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end