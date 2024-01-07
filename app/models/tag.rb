class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :reviews, through: :taggings

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
