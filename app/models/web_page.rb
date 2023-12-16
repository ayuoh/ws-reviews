class WebPage < ApplicationRecord
  belongs_to :domain
  has_many :reviews, dependent: :destroy

  validates :url, presence: true, uniqueness: true, length: { maximum: 260 }
end
