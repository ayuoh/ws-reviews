class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index; end

  def show; end

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
      redirect_to reviews_path, success: '投稿しました。'
    else
      flash.now[:danger] = '投稿できませんでした。'
      @url = url_param
      @tags = params.require(:review)[:tag_names]
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  private

  def review_params
    params.require(:review).permit(:title, :content, :implementation_start_date, :implementation_last_date, :recruitment_start_date, :recruitment_last_date, :prefecture, :fee, :target)
  end

  def url_param
    params.require(:review).permit(:url)[:url]
  end

  def tag_params
    tags = params.require(:review)[:tag_names].split(' ')
    tags.map!(&:strip)
  end
end
