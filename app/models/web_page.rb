class WebPage < ApplicationRecord
  belongs_to :organizer
  has_many :reviews, dependent: :destroy

  validates :url, presence: true, uniqueness: true, length: { maximum: 260 }
  validate :response_code200

  # validate
  def response_code200
    response = HTTP.get(url)
    return if response.code >= 200 && response.code < 400

    errors.add(:url, 'urlが正しくありません。')
  end
end
