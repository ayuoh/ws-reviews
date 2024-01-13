class UsersController < ApplicationController
  def destroy
    current_user.destroy!
    redirect_to root_url, success: t('flash.users.delete'), status: :see_other
  end
end
