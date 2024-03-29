class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to root_path, danger: t('default.message.require_login')
  end
end
