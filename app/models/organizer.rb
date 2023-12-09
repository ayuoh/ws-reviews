class Organizer < ApplicationRecord
  has_many :web_pages, dependent: :destroy

  validates :domain, presence: true, length: { maximum: 260 }
end
