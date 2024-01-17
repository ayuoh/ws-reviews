class FavoritesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    current_user.favorite(@review)
  end

  def destroy
    @review = current_user.favorites.find(params[:id]).review
    current_user.unfavorite(@review)
  end
end
