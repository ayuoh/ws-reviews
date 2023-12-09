class Review < ApplicationRecord
  belongs_to :user
  belongs_to :web_page

  enum target: { everyone: 0, actor: 1, director: 2, other: 3 }

  has_many :taggings, dependent: :destroy
  has_many :tagging_tags, through: :taggings, source: :tag
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :imprementation_start_date, presence: true
  validates :imprementation_last_date, presence: true
end
