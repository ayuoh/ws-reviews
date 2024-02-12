class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show own_reviews]
  before_action :set_review, only: %i[edit update destroy]

  def index
    order = sort_by
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).order(order[0]).order(order[1]).includes(:user, :tags, :web_page).page params[:page]
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    set_organizer_and_webpage

    @review.satisfaction = @review.satisfaction.round(-1)

    if @review.save && @review.save_tag(tag_params)
      redirect_to root_path, success: t('flash.reviews.success.create')
    else
      flash.now[:danger] = t('flash.reviews.failed.create')
      @url = url_param
      @tags = params.require(:review)[:tag_names]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @url = @review.web_page.url
    @tags = @review.tags.map { |tag| tag.name }.join(', ')
  end

  def update
    update_params = review_params
    set_organizer_and_webpage

    update_params[:satisfaction] = update_params[:satisfaction].to_i.round(-1)

    if @review.update(update_params) && @review.save_tag(tag_params)
      redirect_to review_path(@review), success: t('flash.reviews.success.update')
    else
      flash.now[:danger] = t('flash.reviews.failed.update')
      @url = url_param
      @tags = params.require(:review)[:tag_names]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy!
    redirect_to root_url, success: t('flash.reviews.success.destroy'), status: :see_other
  end

  def favorites
    @q = current_user.favorite_reviews.ransack(params[:q])
    @reviews = @q.result(distinct: true).includes(:user).order(created_at: :desc).page params[:page]

    recommended_review
  end

  def own_reviews
    @reviews = Review.joins(:user).where(user: { id: params[:user_id] }).includes(:user, :tags, :web_page).order(created_at: :desc).page params[:page]
    render :my_reviews
  end

  private

  def review_params
    params.require(:review).permit(:content, :implementation_start_date, :implementation_last_date, :satisfaction, :genre, :prefecture, :fee)
  end

  def url_param
    params.require(:review).permit(:url)[:url]
  end

  def tag_params
    tags = params.require(:review)[:tag_names].split(',')
    tags.map!(&:strip)
  end

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def set_organizer_and_webpage
    organizer = Organizer.find_or_save_organizer(url_param)
    web_page = organizer.web_pages.find_or_create_by(url: url_param)
    @review.web_page_id = web_page.id
  end

  def sort_by
    if params[:by] == 'satisfaction'
      if params[:sort] == 'asc'
        order_1 = [satisfaction: :asc]
      else
        order_1 = [satisfaction: :desc]
      end
      order_2 = [created_at: :desc]
    else
      if params[:sort] == 'asc'
        order_1 = [created_at: :asc]
      else
        order_1 = [created_at: :desc]
      end
      order_2 = []
    end

    [order_1, order_2]
  end

  def recommended_review
    favorite = Favorite.where(user_id: current_user.id).order(created_at: :desc).first
    return unless favorite.present?

    # 最近お気に入りにタグがあるか確認
    fav_taggnings = Tagging.where(review_id: favorite.review_id)
    return unless fav_taggnings.present?

    # 最近お気に入りにした投稿のタグをとってくる
    fav_tags = []
    fav_taggnings.each do |ft|
      fav_tags << Tag.joins(taggings: :review).where(id: ft.tag_id).distinct.to_a
    end
    return unless fav_tags.present?

    # 検索したいtag_idを配列に格納する
    fav_tag_ids = []
    fav_tags.each { |t| fav_tag_ids << t[0] }

    # おすすめしたいレビューを取得
    pre_recommended_review = Review.joins(:taggings).where(taggings: { tag_id: fav_tag_ids }).where.not(reviews: { user_id: current_user.id })

    @recommended_review = pre_recommended_review.where.not(id: favorite.review_id).order(created_at: :desc).first
  end
end
