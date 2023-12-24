class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :reviews, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review

  validates :name, presence: true, length: { maximum: 50 }
  validates :twitter_name, presence: true, uniqueness: true
  validates :twitter_id, presence: true, uniqueness: true

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
end
