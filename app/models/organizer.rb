class Organizer < ApplicationRecord
  has_many :web_pages, dependent: :destroy

  validates :name,  uniqueness: true, length: { maximum: 50 }
end
