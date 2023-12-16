class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :reviews, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true
  validates :twitter, uniqueness: true
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

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
