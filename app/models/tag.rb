class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tagging_reviews, through: :taggings, source: :review

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
