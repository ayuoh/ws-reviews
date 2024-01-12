class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, success: t('flash.user_sessions.login')
    else
      flash.now[:danger] = t('flash.user_sessions.cant_login')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('flash.user_sessions.logout')
  end
end
