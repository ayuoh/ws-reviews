class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[search]

  def search
    @tags = Tag.joins(:taggings).where('name like ?', "%#{params[:q]}%").distinct
    respond_to do |format|
      format.js
    end
  end
end
