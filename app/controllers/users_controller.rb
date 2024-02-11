class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    @user.storage_avatar_image.purge

    respond_to do |format|
      if @user.update(profile_params)
        format.html { redirect_to edit_user_path, success: t('flash.reviews.success.update') }
        format.json { render :edit, status: :ok, location: @user }
      else
        flash.now[:danger] = t('flash.reviews.failed.update')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
    params.require(:user).permit(:name, :public_twitter, :avatar, :storage_avatar_image, :storage_avator_image_cache)
  end
end
