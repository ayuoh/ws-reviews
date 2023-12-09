class WebPage < ApplicationRecord
  belongs_to :domain
  has_many :reviews, dependent: :destroy

  validates :url, presence: true, length: { maximum: 260 }
end
