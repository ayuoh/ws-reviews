class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :reviews, through: :taggings

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  # ransack
  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
