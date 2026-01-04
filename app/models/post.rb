class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :body, :country, presence: true
  validate :images_presence
  validate :images_count_within_limit

  def self.ransackable_attributes(auth_object = nil)
    %w[title body country region]
  end

  #  関連検索はしない
  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def images_presence
    errors.add(:images, "を1枚以上追加してください") unless images.attached?
  end

  def images_count_within_limit
    if images.attached? && images.count > 5
      errors.add(:images, "は5枚までしかアップロードできません")
    end
  end
end
