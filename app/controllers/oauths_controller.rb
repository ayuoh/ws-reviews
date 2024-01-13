class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if (@user = login_from(provider))
      redirect_to root_path, success: t('flash.oauths.login_first')
    else
      begin
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, success: t('flash.oauths.login')
      rescue StandardError
        redirect_to root_path, danger: t('flash.oauths.cant_login')
      end
    end
  end
end
