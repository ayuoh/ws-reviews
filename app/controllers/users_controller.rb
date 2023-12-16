class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to login_url
      else
        flash.now[:danger] = '新規登録できませんでした。'
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mail, :password, :password_confirmation)
  end
end
