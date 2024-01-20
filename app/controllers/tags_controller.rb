class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[search]

  def search
    @tags = Tag.joins(:taggings).where('name like ?', "%#{params[:q]}%").distinct
    respond_to do |format|
      format.js
    end
  end

  def all_search
    query = params[:query]
    @tags = Tag.where('name LIKE ?', "%#{query}%")
    @tags = @tags.pluck(:name)
    render json: @tags
  end
end
