class Review < ApplicationRecord
  @@genres = %w[ストレート・プレイ リーディング インプロバイゼーション クラウン ミュージカル アクション シアターゲーム 映像 その他]

  @@prefectures = %w[北海道 青森 岩手 宮城 秋田 山形 福島 茨城 栃木 群馬 埼玉 千葉 東京 神奈川 新潟 富山 石川 福井 山梨 長野 岐阜 静岡 愛知 三重 滋賀 京都 大阪 兵庫 奈良 和歌山 鳥取 島根 岡山 広島 山口 徳島 香川 愛媛 高知 福岡 佐賀 長崎 熊本 大分 宮崎 鹿児島 沖縄 オンライン その他]

  belongs_to :user
  belongs_to :web_page, validate: false

  exnum target: { everyone: 0, actor: 1, director: 2, other: 3 }

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :content, presence: true, length: { maximum: 1000 }
  validates :implementation_start_date, presence: true
  validates :implementation_last_date, presence: true
  validate :check_implementation_date
  validates :fee, numericality: true, allow_blank: true
  validates :satisfaction, presence: true

  def save_tag(sent_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |tag|
      tags.delete Tag.find_by(name: tag)
    end

    # 新しいタグを保存
    new_tags.each do |tag|
      new_post_tag = Tag.find_or_create_by(name: tag)
      tags << new_post_tag if !tag.empty? && tags.where(name: tag).blank?
    end
  end

  # validate
  def check_implementation_date
    return if implementation_start_date <= implementation_last_date

    errors.add(:implementation_last_date, 'が正しくありません')
  end

  # arrays
  def self.genres
    @@genres
  end

  def self.prefectures
    @@prefectures
  end

  # ransack
  def self.ransackable_attributes(_auth_object = nil)
    %w[content prefecture target genre]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[taggings tags]
  end
end
