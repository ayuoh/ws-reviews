class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[search]

  def search
    @tags = Tag.where('name like ?', "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end
end
