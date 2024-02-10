class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to edit_user_path, success: t('flash.reviews.success.update')
    else
      flash.now[:danger] = t('flash.reviews.failed.update')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy!
    redirect_to root_url, success: t('flash.users.delete'), status: :see_other
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:name, :public_twitter, :avatar, :avatar_cache)
  end
end
