class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:sucess] = 'login成功'
      redirect_to @user
    else
      flash[:danger] = 'login失敗'
      render 'new'
    end
  end

  def destroy
    sesiion[:user_id] = nil
    falsh[:sucess] = 'logoutしました'
    redirect_to root_patj
  end
  
  private
  def login(email, password)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
    
  end
end
