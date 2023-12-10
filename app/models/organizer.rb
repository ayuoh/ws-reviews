class Organizer < ApplicationRecord
  has_many :web_pages, dependent: :destroy

  validates :domain, presence: true, uniqueness: true, length: { maximum: 260 }
  validates :name, length: { maximum: 50 }
end
