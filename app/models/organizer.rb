class Organizer < ApplicationRecord
  has_many :web_pages, dependent: :destroy

  validates :domain, presence: true, uniqueness: true, length: { maximum: 260 }
  validates :name, length: { maximum: 50 }

  def self.find_or_save_organizer(url)
    uri = Addressable::URI.parse(url)
    Organizer.find_or_create_by(domain: uri.host)
  end
end
