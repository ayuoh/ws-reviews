class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_review, only: %i[edit update destroy]

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).order(created_at: :desc).includes(:user, :tags, :web_page).page params[:page]
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)

    organizer = Organizer.find_or_save_organizer(url_param)
    web_page = organizer.web_pages.find_or_create_by(url: url_param)
    @review.web_page_id = web_page.id

    @review.set_default_title(url_param) if @review.title.blank?

    if @review.save && @review.save_tag(tag_params)
      redirect_to root_path, success: '投稿しました。'
    else
      flash.now[:danger] = '投稿できませんでした。'
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
    organizer = Organizer.find_or_save_organizer(url_param)
    web_page = organizer.web_pages.find_or_create_by(url: url_param)
    @review.web_page_id = web_page.id

    if @review.title.blank?
      @review.set_default_title(url_param)
      update_params[:title] = @review.title
    end

    if @review.update(update_params) && @review.save_tag(tag_params)
      redirect_to review_path(@review), success: '変更しました。'
    else
      flash.now[:danger] = '変更できませんでした。'
      @url = url_param
      @tags = params.require(:review)[:tag_names]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy!
    redirect_to root_url, success: '削除しました。'
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :implementation_start_date, :implementation_last_date, :recruitment_start_date, :recruitment_last_date, :prefecture, :fee, :target)
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
end
