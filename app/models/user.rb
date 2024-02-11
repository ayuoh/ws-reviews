class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :storage_avatar_image

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review

  validates :name, presence: true, length: { maximum: 50 }
  validates :twitter_name, presence: true, uniqueness: true
  validates :twitter_id, presence: true, uniqueness: true
  validate :storage_avatar_image_size

  def own?(object)
    self.id == object.user_id
  end

  def favorite(review)
    favorite_reviews << review
  end

  def unfavorite(review)
    favorite_reviews.destroy(review)
  end

  def favorite?(review)
    favorite_reviews.include?(review)
  end

  def storage_avatar_image_size
    if storage_avatar_image.attached? && storage_avatar_image.blob.byte_size > 1.megabytes
      errors.add(:storage_avatar_image, '：1MB以下のファイルをアップロードしてください')
    end
  end
end
