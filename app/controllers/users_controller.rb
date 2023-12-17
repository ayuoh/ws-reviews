class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    def create
      @user = User.new(user_params)

      if @user.save
        @current_user = @user
        redirect_to root_url
      else
        flash.now[:danger] = '新規登録できませんでした。'
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
